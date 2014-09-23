React = require 'react'
{div, input, label} = require 'reactionary'

module.exports = React.createClass

  propTypes:
    id: React.PropTypes.string.isRequired
    label: React.PropTypes.string.isRequired
    fieldType: React.PropTypes.string.isRequired
    placeholder: React.PropTypes.string

  handleChange: ->
    @props.onChange @refs[@props.id].getDOMNode().value

  render: ->
    div
      className: 'form-group',
        label
          className: 'sr-only'
          htmlFor: @props.id,
            @props.label
        input
          className: 'form-control'
          id: @props.id
          ref: @props.id
          value: @props.value
          onChange: @handleChange
          type: @props.fieldType
          placeholder: @props.placeholder
