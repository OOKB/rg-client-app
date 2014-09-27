React = require 'react'
{p, h3, div, ul, li, label, input} = require 'reactionary'

Items = require './collection/items'
Share = require './share'
FavContent = require './favs_content'

module.exports = React.createClass
  getInitialState: ->
    favUrl: app.me.favUrl

  componentWillMount: ->
    app.bitly.getOrFetch app.me.favUrl, (err, model) =>
      if model and model.customUrl
        @setState favUrl: model.customUrl

  render: ->

    favsMenu = ul
      className: 'favs-menu',
        li
          className: 'share',
            Share shareUrl: @state.favUrl
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
