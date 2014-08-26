React = require 'react'
{nav, div, button, h3, p, span, ul, li} = require 'reactionary'

Info = require '../el/info'
FavButton = require '../el/button_fav'
CloseButton = require '../el/button_close'
module.exports = React.createClass

  handleXclick: ->
    window.history.back()

  render: ->
    nav className: 'item-detail-header',
      div className: 'controls',
        ul {},
          li className: 'fav',
            FavButton
              model: @props.model
              itemState: @props.itemState
              setItemState: @props.onUserInput
          li className: 'close',
            CloseButton
              onClick: @handleXclick
        h3 className: 'hidden-md hidden-lg', 'Details'
        button
          className: 'toggle hidden-md hidden-lg'
          type: 'button',
            'Reveal Menu'
      div className: 'item-detail-content',
        Info @props
