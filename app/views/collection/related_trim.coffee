React = require 'react'
{div, ul, li, a, img, i} = require 'reactionary'

CloseButton = require '../el/button_close'
ItemEl = require './item_el'
ItemButtons = require '../el/item_buttons'
Info = require '../el/info'
FavAlertBox = require '../el/fav_alert'
ProjectBox = require '../el/project_box'

Button = require '../el/button'
module.exports = React.createClass
  closeColors: ->
    document.querySelector('img#'+@props.id).scrollIntoView(true)
    @props.setItemState colorBoxView: false

  getInitialState: ->
    buttonsFor: ''
    infoBoxView: false
    favBoxView: false
    projectBoxView: false

  render: ->
    itemCount = @props.collection.length

    # Color icons.
    relatedColorItems = []
    @props.collection.forEach (item) =>
      if @state.infoBoxView and @state.buttonsFor == item.id
        infoBox = Info model: item
      else
        infoBox = false
      # Favs
      if @state.favBoxView == item.id
        favAlert = FavAlertBox
          itemState: @state
          setItemState: (newSt) => @setState newSt
          model: item
      else
        favAlert = false

      # Add to projects
      if @state.projectBoxView == item.id
        projectBox = ProjectBox
          itemState: @state
          setItemState: (newSt) => @setState newSt
          model: item
      else
        projectBox = false

      relatedColorItems.push li
        key: item.id
        className: 'related-item',
          ItemEl
            imgSize: 'small'
            model: item
            onMouseOver: (e) => @setState buttonsFor: e.target.id
          ItemButtons
            setItemState: (newSt) => @setState newSt
            itemState: @state
            buttonsFor: @state.buttonsFor
            model: item
            initState: @props.initState
            extraButtons: true
            buttonTypes: ['fav', 'info']
          infoBox
          favAlert
          projectBox

    relatedColorsList = ul
      className: 'list',
        relatedColorItems

    return div
      id: 'related-colors'
      className: 'trim',
        relatedColorsList
        CloseButton
          onClick: @closeColors
        Button
          buttonInfo:
            onClick: @closeColors
            className: 'btn-text'
            label: 'Close Colors'
