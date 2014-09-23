React = require 'react'
{div, p, button, a, select, option, label} = require 'reactionary'

# Confirm item added to favorites
CloseButton = require './button_close'

module.exports = React.createClass
  getInitialState: ->
    selected: app.me.projects.at(0).id

  close: ->
    @props.setItemState projectBoxView: false

  addItem: ->
    project = app.me.projects.get(@state.selected)
    project.addEntity @props.model.id
    @props.setItemState projectBoxView: false
    return

  render: () ->
    unless @props.itemState.projectBoxView
      return false
    options = app.me.projects.map (project) ->
      if project.name
        option
          key: project.id
          value: project.id,
            project.name
    div
      id: "project-list-select"
      className: "alert-favorite alert alert-dismissable",
        CloseButton
          onClick: @close
        label
          htmlFor: "project-trade-list",
            'Add to'
        select
          value: @state.selected
          onChange: (e) =>
            @setState selected: e.target.value
          id: "project-trade-list",
            options
        button
          type: 'submit'
          onClick: @addItem
          className: "btn btn-default uppercase",
            'Add'
