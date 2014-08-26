React = require 'react'

Button = require './button'

# Action buttons

module.exports = React.createClass

  propTypes:
    onClick: React.PropTypes.func.isRequired

  render: ->
    Button
      model: {}
      buttonInfo:
        className: 'close'
        onClick: @props.onClick
        label: 'X'
      active: false
