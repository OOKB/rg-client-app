React = require 'react'
{div, input, label} = require 'reactionary'

module.exports = React.createClass

  propTypes:
    id: React.PropTypes.string.isRequired
    label: React.PropTypes.string.isRequired
    fieldType: React.PropTypes.string.isRequired
    placeholder: React.PropTypes.string

  render: ->
    div
      className: 'form-group col-sm-6',
        label
          className: 'sr-only'
          htmlFor: @props.id,
            @props.label
        input
          className: 'form-control'
          id: @props.id
          ref: @props.id
          type: @props.fieldType
          placeholder: @props.placeholder
