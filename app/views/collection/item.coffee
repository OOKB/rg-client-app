React = require 'react'
{div, ul, li, p, button, img, i, a, span} = require 'reactionary'
_ = require 'lodash'
SubCollection = require 'ampersand-subcollection'

Pager = require '../el/pager'
ItemEl = require './item_el'
ItemButtons = require '../el/item_buttons'
Info = require '../el/info'
Related = require '../detail/related'
RelatedTrim = require './related_trim'
FavAlertBox = require '../el/fav_alert'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: ''
    windowWidth: window.innerWidth
    colorBoxView: false
    infoBoxView: false
    favBoxView: false

  setPgPre: (e) ->
    if e.preventDefault
      e.preventDefault()
    if @props.initState.pageIndex != 1
      @props.setRouterState pageIndex: @props.initState.pageIndex-1
    else if @props.threeUp
      @props.setRouterState pageIndex: @props.initState.totalPages
    else
      console.log 'pre'

  setPgNext: (e) ->
    if e.preventDefault
      e.preventDefault()
    if @props.initState.pageIndex != @props.initState.totalPages
      @props.setRouterState pageIndex: @props.initState.pageIndex+1
    else if @props.threeUp
      @props.setRouterState pageIndex: 1
    else
      console.log 'next'

  render: ->
    onClick = undefined
    preventDetail = false
    colorBoxView = false
    itemClassName = ''
    # threeUp has special pg left/right.
    if @props.threeUp
      index = @props.index
      activeId = @props.itemState and @props.itemState.buttonsFor
      # Only center item has link.
      if item.id == activeId
        href = item.detail
      # First item is pager back.
      else if index == 0
        onClick = @setPgPre
        preventDetail = true
      # Last item is pager forward.
      else if index == 2
        preventDetail = true
        onClick = @setPgNext
    # Related colors box.
    if colorBoxView
      itemClassName += ' open'
      relatedProps =
        model: item
        section: @props.initState.section
        setItemState: (newSt) => @setState newSt
        collection: new SubCollection app.items.collection,
          where:
            patternNumber: item.patternNumber
            hasImage: item.hasImage
          filter: (model) -> model.id != item.id
        setParentState: (newSt) =>
          @setState newSt
        setContainerState: () -> return
      if @props.isOnTrim
        relatedColors = RelatedTrim relatedProps
      else
        relatedColors = Related relatedProps
    else
      relatedColors = false

    # Info box.
    if @state.infoBoxView and buttonsFor == item.id
      infoBox = Info model: item
    else
      infoBox = false

    # Fav alert box.
    if @state.favBoxView == item.id
      favAlert = FavAlertBox
        itemState: @state
        setItemState: (newSt) => @setState newSt
        model: item
    else
      favAlert = false
    li
      className: itemClassName
      key: item.id,
        # Item
        itemEl
        ItemButtons
          setItemState: (newSt) => @setState newSt
          itemState: @state
          buttonsFor: buttonsFor
          model: item
          initState: @props.initState
          extraButtons: @props.extraButtons
        relatedColors
        infoBox
        favAlert
