React = require 'react'
{div, p, ul, li, button, img, i, a} = require 'reactionary'
_ = require 'lodash'
SubCollection = require 'ampersand-subcollection'

Pager = require '../el/pager'
Related = require '../detail/related'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: ''
    windowWidth: window.innerWidth
    colorBoxView: false

  setButtonsFor: (e) ->
    unless @props.threeUp
      @setState buttonsFor: e.target.id

  colorsClick: (e) ->
    if 'passementerie' == @props.initState.category
      if @props.initState.patternNumber
        @props.setRouterState
          patternNumber: false
      else
        @props.setRouterState
          patternNumber: e.target.value
    else
      @setState colorBoxView: !@state.colorBoxView

  setPgPre: (e) ->
    console.log 'pre'
    if e.preventDefault
      e.preventDefault()
    if @props.initState.pageIndex != 1
      @props.setRouterState pageIndex: @props.initState.pageIndex-1

  setPgNext: (e) ->
    console.log 'next'
    if e.preventDefault
      e.preventDefault()
    if @props.initState.pageIndex != @props.initState.totalPages
      @props.setRouterState pageIndex: @props.initState.pageIndex+1

  imgSize: ->
    if @props.threeUp == false or @props.initState.category == 'passementerie'
      return 'small'
    ww = @state.windowWidth
    if ww < 1280
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

  render: ->
    list = []
    if @props.threeUp
      buttonsFor = @props.collection.models[1].id
    else
      buttonsFor = @state.buttonsFor
    imgSize = @imgSize()
    # List
    @props.collection.forEach (item, index) =>
      if buttonsFor == item.id
        buttons = []
        if @props.extraButtons
          colorButtonClass = 'item-colors'
          if @state.colorBoxView or @props.initState.patternNumber
            colorButtonClass += ' active'
          buttons.push button
            key: 'colors'
            value: item.patternNumber
            onClick: @colorsClick
            className: colorButtonClass,
              'Colors'
        buttons.push button
          key: 'favs'
          className: 'item-favorite',
            '+'
        if @props.extraButtons
          buttons.push button
            key: 'details'
            className: 'item-details',
              '='
        # Action buttons
        buttons = div
          className: 'item-icons hidden-xs',
            buttons
      else
        buttons = ''

      # Item Image
      itemImg = img
        id: item.id
        width: item._file[imgSize].width
        height: item._file[imgSize].height
        src: item._file[imgSize].path,
        onMouseOver: @setButtonsFor
      relatedColors = ''
      if @props.threeUp
        if buttonsFor == item.id
          detailLink = true
          if @state.colorBoxView
            relatedProps =
              id: item.id
              section: @props.initState.section
              patternNumber: item.patternNumber
              collection: new SubCollection app.items.collection,
                where:
                  patternNumber: item.patternNumber
                  hasDetail: true
              setParentState: (newSt) =>
                @setState newSt
              setContainerState: () -> return
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

    return div
      className: 'pg-size-' + @props.initState.pgSize
      id: 'collection-' + @props.initState.category,
        ul
          className: 'list',
            list
