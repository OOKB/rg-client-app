React = require 'react'
{div, ul, li, button, span} = require 'reactionary'
#_ = require 'lodash'

module.exports = React.createClass

  project: (project) ->
    li
      key: project.id
      className: 'project',
        span
          className: 'list-name',
            project.name
        span
          className: 'list-edit',
            button 'edit'
            button 'delete'


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
