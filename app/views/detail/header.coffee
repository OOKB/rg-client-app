React = require 'react'
{nav, div, button, h3, p, span, ul, li} = require 'reactionary'

Info = require '../el/info'
FavButton = require '../el/button_fav'
ProjectButton = require '../el/button_project'
CloseButton = require '../el/button_close'

module.exports = React.createClass
  getInitialState: ->
    forceInfo: false

  handleXclick: ->
    window.history.back()

  toggleInfo: ->
    @setState forceInfo: !@state.forceInfo

  render: ->
    if @props.windowWidth > 991 or @state.forceInfo
      itemInfo = div
        className: 'item-detail-content',
          Info @props
    else
      itemInfo = false

    if app.me.loggedIn
      favThisButton = ProjectButton
        key: 'project'
        model: @props.model
        setItemState: @props.onUserInput
        itemState: @props.itemState
        section: 'detail'
        projectId: null
    else
      favThisButton = FavButton
        key: 'fav'
        model: @props.model
        setItemState: @props.onUserInput
        itemState: @props.itemState

    mobileClassName = 'toggle hidden-md hidden-lg'
    if @state.forceInfo then mobileClassName += ' active'

    nav className: 'item-detail-header',
      div className: 'controls',
        ul {},
          li className: 'fav',
            favThisButton
          li className: 'close',
            CloseButton
              onClick: @handleXclick
        h3 className: 'hidden-md hidden-lg', 'Details'
        button
          onClick: @toggleInfo
          className: mobileClassName
          type: 'button',
            'Reveal Menu'
      itemInfo
