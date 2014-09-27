React = require 'react'
{div, label, input} = require 'reactionary'

FavContent = require './favs_content'

module.exports = React.createClass
  componentDidMount: ->
    @selectFavUrl()

  selectFavUrl: ->
    @refs.favUrl.getDOMNode().select()

  render: ->
    div
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
          value: @props.shareUrl
          readOnly: true
          onMouseOver: @selectFavUrl
