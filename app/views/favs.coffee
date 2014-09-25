React = require 'react'
{p, h3, div, ul, li, label, input} = require 'reactionary'

Items = require './collection/items'

FavContent = require './favs_content'

module.exports = React.createClass
  getInitialState: ->
    favUrl: app.me.favUrl

  componentWillMount: ->
    app.bitly.getOrFetch app.me.favUrl, (err, model) =>
      if model and model.customUrl
        @setState favUrl: model.customUrl
        @selectFavUrl()

  componentDidMount: ->
    @selectFavUrl()

  selectFavUrl: ->
    @refs.favUrl.getDOMNode().select()

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
              ref: 'favUrl'
              size: '200'
              value: @state.favUrl
              readOnly: true
              onMouseOver: @selectFavUrl
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
