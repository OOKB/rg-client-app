React = require 'react'
{nav, div, button, h3, p, span, ul, li} = require 'reactionary'

Info = require '../el/info'
FavButton = require '../el/button_fav'
CloseButton = require '../el/button_close'
module.exports = React.createClass
  getInitialState: ->
    forceInfo: false

  handleXclick: ->
    window.history.back()

  toggleInfo: ->
    @setState forceInfo: !@state.forceInfo

  render: ->
    if @props.windowWidth > 767 or @state.forceInfo
      itemInfo = div
        className: 'item-detail-content',
          Info @props
    else
      itemInfo = false
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
          onClick: @toggleInfo
          className: 'toggle hidden-md hidden-lg'
          type: 'button',
            'Reveal Menu'
      itemInfo
