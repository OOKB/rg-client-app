React = require 'react'
{div, p, button, a} = require 'reactionary'
_ = require 'lodash'

CloseButton = require './button_close'
TxtField = require './form_text'
# Confirm item added to favorites

module.exports = React.createClass
  getInitialState: ->
    name: ''

  handleSubmit: ->
    if @props.onSave and @state.name
      @props.onSave @state.name

  render: () ->
    div
      className: "new-project alert alert-dismissable",
        CloseButton
          onClick: @props.onClose
        TxtField
          id: 'new-project-name'
          label: 'Project Name'
          placeholder: 'Project name'
          fieldType: 'text'
          value: @state.name
          onChange: (val) => @setState name: val
        button
          onClick: @handleSubmit
          type: 'submit'
          className: 'btn btn-default',
            'Create'
