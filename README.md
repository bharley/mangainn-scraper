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
    $ npm start

This script doesn't run forever, and it is really only effective when run periodically (e.g. with crontab).

## Running with Docker
You can also run this in a Docker container:

    $ wget -O settings.yaml https://raw.githubusercontent.com/bharley/mangainn-scraper/master/settings.yaml.example
    ... make the proper changes to settings.yaml using your editor of choice
    $ docker create \
        -v /opt/scraper/.data.json \
        --name scraper-data \
        bharley/mangainn-scraper \
        /bin/true
    $ docker run \
        -v "settings.yaml:/opt/scraper/settings.yaml" \
        --volumes-from scraper-data \
        --restart=always \
        bharley/mangainn-scraper

[mangainn.me]: http://www.mangainn.me
[PushBullet]: https://www.pushbullet.com
[NodeJS]: https://nodejs.org
[CoffeeScript]: http://coffeescript.org
