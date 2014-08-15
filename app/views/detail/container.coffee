React = require 'react'
{div, table, tbody, tr, td, button, h3, p, span} = require 'reactionary'

HeaderBar = require './header'
Switcher = require './buttons'

module.exports = React.createClass
  getInitialState: ->
    color_id: @props.initColor
    patternNumber: @props.patternNumber
    pageIndex: 0
    isRelated: false

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
    item = @props.collection.get @state.patternNumber+'-'+@state.color_id
    #console.log item.toJSON()
    color_toggle_class = 'toggle-colors hidden-xs'
    if item.far
      color_toggle_class += ' with-far'
    props =
      model: item
      collection: @props.collection
      pageIndex: @state.pageIndex
      onUserInput: @handleUserInput
      isRelated: @state.isRelated
      patternNumber: @state.patternNumber
    div
      id: 'container-detail'
      className: 'item-detail '+item.category,
        HeaderBar props
        Switcher props
