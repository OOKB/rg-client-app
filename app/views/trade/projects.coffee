React = require 'react'
{div, ul, li, button, span, input, a} = require 'reactionary'
_ = require 'lodash'

Favs = require '../favs_content'
NewProject = require '../el/project_new'

module.exports = React.createClass
  getInitialState: ->
    editName: null
    projects: app.me.projects
    addProject: false

  handleEdit: (e) ->
    if @state.editName == e.target.value
      @setState editName: null
      @_saveName() #closing should save
    else
      if @state.editName #switching should save.
        @_saveName()
      @setState editName: e.target.value

  handleDelete: (e) ->
    app.me.projects.get(e.target.value).destroy
      error: ->
        alert('There was an error destroying the task')
      success: ->
        console.log 'gone'
    @forceUpdate()

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

  newProject: (name) ->
    app.me.projects.create
      name: name
    @setState addProject: false

  nameTxt: (name, id) ->
    if id == @props.initState.projectId
      link = '#trade/projects'
    else
      link = '#trade/projects/'+id
    span
      className: 'list-name',
        a
          href: link,
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
      name = @nameTxt project.name, project.id

    if project.id == @props.initState.projectId
      projectItems = Favs @props
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
              onClick: @handleDelete
              value: project.id,
                'delete'
        projectItems

  render: ->
    if @state.projects
      projects = @state.projects.map @project
    else
      projects = 'No projects.'
    if @state.addProject
      newProj = NewProject
        onClose: => @setState addProject: false
        onSave: @newProject
    else
      newProj = false

    div
      className: 'trade-projects text-center',
        div
          className: 'row',
            button
              onClick: => @setState addProject: true
              className: 'new-project',
                'Add New Project'
            newProj
        div
          className: 'existing-projects',
            ul projects
