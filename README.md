rg-client-app
===============

[![Join the chat at https://gitter.im/OOKB/rg-client-app](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/OOKB/rg-client-app?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

pricelist, summer sale, collection completion and a few other new features for rogersandgoffigon.com.

+++++++++++++++

This is showing off a few things.

* Gulp
* Browser Sync
* Less

## Installing the first time.

If you haven't already, install gulp globally `npm i gulp -g`. When installing gulp globally you may need to use sudo. `sudo npm i gulp -g`

    git clone git@github.com:sundaysenergy/client-dev-demo.git
    cd client-dev-demo
    npm i
    gulp

## Updating

    git pull
    npm i
    gulp

## Update the prod site

    git pull
    gulp prod

## Data
Used for reference. The future.
* http://v6.rogersandgoffigon.com/_order-track/items/rg?disc=true
* http://v6.rogersandgoffigon.com/_order-track/items/rg (dong)

Used for current RG data.

1. https://rg3.cape.io/items.json (aling) `env NODE_ENV=production forever start /usr/local/node/cape3`
1. http://v5.rogersandgoffigon.com/index.json (45.33.30.19 cape5) Used for images.
1. http://social.cape.io/order-track/kb/summer (dong) Used to proxy order-track

## Images

http://v6.rogersandgoffigon.com/
