React = require 'react'
{p, h3, div, ul, li, label, input} = require 'reactionary'

Items = require './collection/items'

FavContent = require './favs_content'

module.exports = React.createClass

  render: ->

    favsMenu = ul
      className: 'favs-menu',
        li
          className: 'share',
            label
              className: 'uppercase'
              htmlFor: 'share-field',
                'Share: '
            input
              id: 'share-field'
              type: 'text'
              value: 'http://fav.rogersandgoffigon.com/'
              readOnly: true
        li
          h3
            className: 'uppercase',
              'Favorites'

    div
      id: 'container-favs',
        p
          key: 'intro'
          className: 'text-area',
            'Browse and edit your favorites.'
        favsMenu
        FavContent @props
