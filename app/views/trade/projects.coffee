React = require 'react'
{div, ul, li, button, span, input} = require 'reactionary'
_ = require 'lodash'

Favs = require '../favs_content'

module.exports = React.createClass
  getInitialState: ->
    editName: null
    projects: app.me.projects

  handleEdit: (e) ->
    if @state.editName == e.target.value
      @setState editName: null
      @_saveName() #closing should save
    else
      if @state.editName #switching should save.
        @_saveName()
      @setState editName: e.target.value

  changeName: (e) ->
    newName = @refs.newName.getDOMNode().value
    id = @state.editName
    app.me.projects.get(id).name = newName
    @state.projects = app.me.projects
    @forceUpdate()
    # Update the project name.

  keyDown: (e) ->
    if e.key and e.key == 'Enter'
      @_saveName()
    return

  _saveName: ->
    id = @state.editName
    project = app.me.projects.get(id)
    @setState editName: null
    # Save it to the db.
    project.save name: project.name

  nameTxt: (name) ->
    span
      className: 'list-name',
        name

  nameForm: (name) ->
    input
      value: name
      onChange: @changeName
      ref: 'newName'
      onKeyDown: @keyDown

  project: (project) ->
    if @state.editName == project.id
      name = @nameForm project.name
    else
      name = @nameTxt project.name

    if project.entities.length
      ids = _.pluck project.entities.models, 'id'
      console.log ids
      projectItems = false
      # Favs
      #   _.extend @props,
      #     ids:
    else
      projectItems = false

    li
      key: project.id
      className: 'project',
        name
        span
          className: 'list-edit',
            button
              className: 'edit',
              onClick: @handleEdit
              value: project.id,
                'edit'
            button
              className: 'delete',
              value: project.id,
                'delete'
        projectItems

  render: ->
    if @state.projects
      projects = @state.projects.map @project
    else
      projects = 'No projects.'
    div
      className: 'trade-projects text-center',
        div
          className: 'row',
            button
              className: 'new-project',
                'Add New Project'
        div
          className: 'existing-projects',
            ul projects
