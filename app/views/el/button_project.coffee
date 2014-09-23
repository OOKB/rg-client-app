React = require 'react'
{button} = require 'reactionary'
_ = require 'lodash'
Button = require './button'

# Action buttons

module.exports = React.createClass

  propTypes:
    model: React.PropTypes.object.isRequired
    itemState: React.PropTypes.object.isRequired
    setItemState: React.PropTypes.func.isRequired

  addItem: (e) ->
    id = e.target.value
    @props.setItemState projectBoxView: id

  rmItem: (e) ->
    entityId = e.target.value
    project = app.me.projects.get(@props.projectId)
    project.rmEntity entityId
    @props.setItemState removedItem: entityId

  data: (buttonType) ->
    switch buttonType
      when 'add'
        key: 'addItem'
        name: 'add-item'
        value: 'id'
        onClick: @addItem
        label: '+'
      when 'rm'
        key: 'rmItem'
        name: 'remove-item'
        value: 'id'
        onClick: @rmItem
        label: '-'

  # Template for the button itself.
  # btn is one of the objects from @data above ^.
  # active is boolean.
  render: ->
    item = @props.model
    # Define based on if user has them in favs.
    if @props.section == 'projects'
      buttonInfo = @data('rm')
    else
      buttonInfo = @data('add')

    Button
      model: item
      buttonInfo: buttonInfo
      active: @props.itemState.projectBoxView != false
