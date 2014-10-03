React = require 'react'
{div, ul, li, p, button, img, i, a, span} = require 'reactionary'
_ = require 'lodash'
SubCollection = require 'ampersand-subcollection'

Pager = require '../el/pager'
Info = require '../el/info'
ItemEl = require './item_el'
ItemButtons = require '../el/item_buttons'
FavAlertBox = require '../el/fav_alert'
ProjectBox = require '../el/project_box'
Related = require '../detail/related'
RelatedTrim = require './related_trim'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: ''
    windowWidth: window.innerWidth
    colorBoxView: false
    infoBoxView: false
    favBoxView: false
    projectBoxView: false

  setButtonsFor: (e) ->
    unless @props.threeUp or @state.colorBoxView
      @setState buttonsFor: e.target.id

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

  imgSize: ->
    if @props.threeUp == false or @props.initState.category == 'passementerie'
      return 'small'
    ww = @state.windowWidth
    if ww < 1090 or @props.initState.pgSize == 500
      return 'small'
    else
      return 'large'

  handleResize: (e) ->
    ww = window.innerWidth
    if ww % 5 == 0
      @setState windowWidth: ww

  componentDidMount: ->
    window.addEventListener 'resize', @handleResize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @handleResize

  noResultsEl: ->
    txt1 = span className: 'category', @props.initState.category
    txt3 = span className: 'search-txt', @props.initState.searchTxt
    if @props.initState.section == 'summer'
      if @props.initState.searchTxt
        txt2 = ' on sale match your search for '
      else
        txt2 = ' on sale '
    else
      txt2 = ' items match your search for '
    div
      className: 'search no-results',
        p 'No ', txt1, txt2, txt3, ' at this time.'

  setItemState: (s) ->
    if s.removedItem
      @props.setRouterState removedItem: s.removedItem
    else
      @setState s

  render: ->
    unless @props.collection.length
      return @noResultsEl()

    isOnTrim = @props.isOnTrim
    imgSize = @imgSize()
    list = []
    if @props.threeUp
      buttonsFor = @props.threeUp
    else
      buttonsFor = @state.buttonsFor

    # List
    itemsArray = @props.collection
    itemsArray.forEach (item, index) =>
      itemProps =
        key: item.id
        model: item
        onMouseOver: @setButtonsFor
        imgSize: imgSize
        windowWidth: @state.windowWidth

      if @props.threeUp
        if index == 0 and @props.collection.length == 3
          itemProps.onClick = @setPgPre
        else if index == 2
          itemProps.onClick = @setPgNext

      relatedColors = false
      itemClassName = 'list-item'

      if @state.favBoxView == item.id
        favAlert = FavAlertBox
          itemState: @state
          setItemState: @setItemState
          model: item
      else
        favAlert = false

      if @state.infoBoxView and buttonsFor == item.id
        infoBox = Info model: item
      else
        infoBox = false

      # Add to projects
      if @state.projectBoxView == item.id
        projectBox = ProjectBox
          itemState: @state
          setItemState: @setItemState
          model: item
      else
        projectBox = false

      if @props.threeUp or isOnTrim
        if buttonsFor == item.id and @state.colorBoxView
          relatedCollection = new SubCollection app.items.collection,
            where:
              patternNumber: item.patternNumber
              hasImage: item.hasImage
            filter: (model) -> model.id != item.id
          relatedProps =
            id: item.id
            initState: @props.initState
            patternNumber: item.patternNumber
            setItemState: @setItemState
            collection: relatedCollection
            items: relatedCollection.models
            setParentState: (newSt) =>
              @setState newSt
            setContainerState: () -> return
          if isOnTrim
            relatedColors = RelatedTrim relatedProps
            itemClassName += ' open'
          else
            relatedColors = Related relatedProps
      if itemsArray.length == 3
        keyId = item.id+index
      else
        keyId = item.id
      list.push li
        className: itemClassName
        key: keyId,
          # Item
          ItemEl itemProps
          ItemButtons
            setItemState: @setItemState
            itemState: @state
            buttonsFor: buttonsFor
            model: item
            initState: @props.initState
            extraButtons: @props.extraButtons
          relatedColors
          infoBox
          favAlert
          projectBox
    cat = @props.initState.category or @props.category
    collectionClassName = 'pg-size-' + @props.initState.pgSize
    unless @props.threeUp
      collectionClassName += ' pg-vert'
    if itemsArray.length == 1
      collectionClassName += ' single-item'
      className = 'list'
    else
      className = 'list size-'+itemsArray.length
    return div
      className: collectionClassName
      id: 'collection-' + cat,
        ul
          className: className,
            list
