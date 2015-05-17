# Load up the modules
fs         = require 'fs'
http       = require 'http'
yaml       = require 'js-yaml'
cheerio    = require 'cheerio'
PushBullet = require 'pushbullet'


# Attempt to load the settings
settings = null
try
  settings = yaml.safeLoad fs.readFileSync('settings.yaml', 'utf8')

  # Validate the settings
  throw 'Error: Settings must have at least one `path` defined' if not settings?.paths?.length
  throw 'Error: Settings must have a PushBullet `api_token` defined' if not settings?.pushbullet?.api_key?
catch e
  console.log 'Error: Settings could not be loaded!'
  console.log if e?.toString? then e.toString() else e


# Set up some variables
dataFile = '.data.json'
host     = 'www.mangainn.me'
pusher   = new PushBullet(settings.pushbullet.api_key)


# Load the data file if we can
data = if fs.existsSync dataFile
         JSON.parse fs.readFileSync('.data.json', 'utf8')
       else
         {}


# Set up the request for each path
for path in settings.paths
  request = http.request {host, path}, (response) ->
    bytes = ''
    response.on 'data', (chunk) -> bytes += chunk
    response.on 'end', -> checkChapters path, bytes.toString()
  request.end()


# Do the work
checkChapters = (path, html) ->
  # Load the HTML into a jQuery emulator thing
  $ = cheerio.load html

  # Select the chapters from the virtual DOM
  chapters = $('.content > div:last-child > table > tr > td:first-child > span > a')

  if not data[path]?.chapters
    data[path] = {chapters: 0}

  # Send a notification if something has changed
  if data[path].chapters < chapters.length
    # Prepare the push notification
    chapter = chapters.last()
    url     = chapter.attr('href')
    title   = chapter.text()

    # Send it off
    pusher.link {}, title, url, (err, res) ->
      # If there wasn't an error, save to file
      if not err?
        data[path].chapters = chapters.length
        fs.writeFileSync dataFile, JSON.stringify(data)
