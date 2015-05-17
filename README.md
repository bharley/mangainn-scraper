# MangaInn Scraper
## About
This is a simple web scraper for [mangainn.me] that will send a [PushBullet] notification when a new chapter is added to a series.

## Usage
Requires [NodeJS] and [CoffeeScript].

    $ git clone https://github.com/bharley/mangainn-scraper
    $ cd mangainn-scraper
    $ npm install
    $ cp settings.yaml.example settings.yaml
    ... make the proper changes to settings.yaml using your editor of choice
    $ coffee scraper.coffee

This script doesn't run forever, and it is really only effective when run periodically (e.g. with crontab).

[mangainn.me]: http://www.mangainn.me
[PushBullet]: https://www.pushbullet.com
[NodeJS]: https://nodejs.org
[CoffeeScript]: http://coffeescript.org