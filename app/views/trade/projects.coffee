React = require 'react'
{div, ul, li, button, span, input} = require 'reactionary'
#_ = require 'lodash'

module.exports = React.createClass
  getInitialState: ->
    editName: null

  handleEdit: (e) ->
    if @state.editName == e.target.value
      @setState editName: null
    else
      @setState editName: e.target.value
    console.log e.target.value

  nameTxt: (name) ->
    span
      className: 'list-name',
        name

  nameForm: (name) ->
    input
      value: name

  project: (project) ->
    console.log @state.editName
    if @state.editName == project.id
      name = @nameForm project.name
    else
      name = @nameTxt project.name
    li
      key: project.id
      className: 'project',
        name
        span
          className: 'list-edit',
            button
              onClick: @handleEdit
              value: project.id,
                'edit'
            button

              value: project.id,
                'delete'

  render: ->
    if app.me.projects.length
      projects = app.me.projects.map @project
    else
      projects = 'No projects.'
    div
      className: 'trade-projects text-center',
        div
          className: 'row',
            button
              className: 'uppercase',
                'Add New Project'
        div
          className: 'existing-projects',
            ul projects
