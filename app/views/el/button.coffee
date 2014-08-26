React = require 'react'
{button} = require 'reactionary'
_ = require 'lodash'

# Action buttons

module.exports = React.createClass

  propTypes:
    model: React.PropTypes.object.isRequired
    buttonInfo: React.PropTypes.object.isRequired
    active: React.PropTypes.bool.isRequired

  # Template for the button itself.
  # btn is one of the objects from @data above ^.
  # active is boolean.
  render: ->
    item = @props.model
    btn = @props.buttonInfo
    active = @props.active
    props =
      key: btn.key
      className: btn.name
      onClick: btn.onClick
    if active
      props.className += ' active'
    if btn.value and item[btn.value]
      props.value = item[btn.value]
    button props, btn.label
