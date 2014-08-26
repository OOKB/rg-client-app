React = require 'react'
{div, ul, li, p, button, img, i, a, span} = require 'reactionary'
_ = require 'lodash'
SubCollection = require 'ampersand-subcollection'

Pager = require '../el/pager'
Info = require '../el/info'
ItemButtons = require '../el/item_buttons'
FavAlertBox = require '../el/fav_alert'
Related = require '../detail/related'
RelatedTrim = require './related_trim'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: ''
    windowWidth: window.innerWidth
    colorBoxView: false
    infoBoxView: false
    favBoxView: false

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
    if ww < 1280 or @props.initState.pgSize == 500
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
    txt2 = span className: 'search-txt', @props.initState.searchTxt
    div
      className: 'search no-results',
        p 'No ', txt1, ' items match your search for ', txt2, '.'

  render: ->
    unless @props.collection.length
      return @noResultsEl()

    list = []
    if @props.threeUp and @props.collection.models[1]
      buttonsFor = @props.collection.models[1].id
    else
      buttonsFor = @state.buttonsFor
    imgSize = @imgSize()
    # List
    @props.collection.forEach (item, index) =>
      buttons = ItemButtons
        setItemState: (newSt) => @setState newSt
        itemState: @state
        buttonsFor: buttonsFor
        model: item
        initState: @props.initState
        extraButtons: @props.extraButtons

      # Item Image
      itemImg = img
        id: item.id
        width: item._file[imgSize].width
        height: item._file[imgSize].height
        src: item._file[imgSize].path,
        onMouseOver: @setButtonsFor
      relatedColors = false
      if @state.favBoxView == item.id
        favAlert = FavAlertBox
          itemState: @state
          setItemState: (newSt) => @setState newSt
          model: item
      else
        favAlert = false
      if @state.infoBoxView and buttonsFor == item.id
        infoBox = Info model: item
      else
        infoBox = false
      isOnTrim = 'passementerie' == @props.initState.category
      if @props.threeUp or isOnTrim
        if buttonsFor == item.id
          unless isOnTrim
            detailLink = true
          if @state.colorBoxView
            relatedProps =
              id: item.id
              section: @props.initState.section
              patternNumber: item.patternNumber
              collection: new SubCollection app.items.collection,
                where:
                  patternNumber: item.patternNumber
                  hasImage: item.hasImage
                filter: (model) -> model.id != item.id
              setParentState: (newSt) =>
                @setState newSt
              setContainerState: () -> return
            if 'passementerie' == @props.initState.category
              relatedColors = RelatedTrim relatedProps
            else
              relatedColors = Related relatedProps
      else if item.hasDetail
        detailLink = true
      else
        detailLink = false

      if detailLink
        itemEl = a
          href: item.detail,
            itemImg
      else
        if @props.initState.pgSize == 3
          if index == 0
            onClick = @setPgPre
          else if index == 2
            onClick = @setPgNext
        else
          onClick = undefined
        itemEl = a
          onClick: onClick
          role: 'button',
            itemImg

      list.push li
        key: item.id,
          # Item
          itemEl
          buttons
          relatedColors
          infoBox
          favAlert
    cat = @props.initState.category or @props.category
    return div
      className: 'pg-size-' + @props.initState.pgSize
      id: 'collection-' + cat,
        ul
          className: 'list',
            list
