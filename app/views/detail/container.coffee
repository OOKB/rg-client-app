React = require 'react'
{div, table, tbody, tr, td, button, h3, p, span} = require 'reactionary'

HeaderBar = require './header'
Switcher = require './buttons'
FavAlert = require '../el/fav_alert'

module.exports = React.createClass
  getInitialState: ->
    isRelated: false
    favBoxView: false
    windowWidth: window.innerWidth

  handleResize: (e) ->
    ww = window.innerWidth
    if ww % 5 == 0
      @setState windowWidth: ww

  componentDidMount: ->
    window.addEventListener 'resize', @handleResize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @handleResize

  handleUserInput: (newSt) ->
    if newSt.color_id
      newSt.isRelated = true
      @props.setRouterState
        color_id: newSt.color_id
    @setState newSt

  loadRelatedImgs: ->
    @props.collection.each (item) ->
      itemImg = new Image()
      itemImg.src = item._file.small.path

  componentWillMount: ->
    # Begin downloading all related images in small 640px.
    @loadRelatedImgs()

  render: ->
    ops = @props.initState
    id = ops.patternNumber + '-' + ops.color_id
    item = @props.collection.get id
    unless item
      console.log @props.collection.models
    color_toggle_class = 'toggle-colors hidden-xs'
    if item.far
      color_toggle_class += ' with-far'
    if item.itemComments
      color_toggle_class += ' with-notes'
    props =
      model: item
      initState: @props.initState
      collection: @props.collection
      pageIndex: @state.pageIndex
      onUserInput: @handleUserInput
      isRelated: @state.isRelated
      patternNumber: ops.patternNumber
      windowWidth: @state.windowWidth
      itemState: @state
      activeId: id
    div
      id: 'container-detail'
      className: 'item-detail '+item.category,
        HeaderBar props
        FavAlert
          itemState: @state
          model: item
          setItemState: (st) => @setState st
        Switcher props
