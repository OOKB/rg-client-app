React = require 'react'
{div, table, tbody, tr, td, button, h3, p, span} = require 'reactionary'

HeaderBar = require './header'
Switcher = require './buttons'

module.exports = React.createClass
  getInitialState: ->
    isRelated: false
    color_id: @props.initState.initColor

  handleUserInput: (newSt) ->
    if newSt.color_id
      newSt.isRelated = true
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
    id = ops.patternNumber+'-'+@state.color_id

    item = @props.collection.get id
    color_toggle_class = 'toggle-colors hidden-xs'
    if item.far
      color_toggle_class += ' with-far'
    props =
      model: item
      collection: @props.collection
      pageIndex: @state.pageIndex
      onUserInput: @handleUserInput
      isRelated: @state.isRelated
      patternNumber: ops.patternNumber
    div
      id: 'container-detail'
      className: 'item-detail '+item.category,
        HeaderBar props
        Switcher props
