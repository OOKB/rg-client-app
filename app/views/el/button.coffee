React = require 'react'
{button} = require 'reactionary'

# Action buttons

module.exports = React.createClass

  propTypes:
    buttonInfo: React.PropTypes.object.isRequired
    model: React.PropTypes.object
    active: React.PropTypes.bool

  # Template for the button itself.
  # btn is one of the objects from @data above ^.
  # active is boolean.
  render: ->
    item = @props.model
    btn = @props.buttonInfo
    active = @props.active
    props =
      key: btn.key or btn.className
      className: btn.name or btn.className or 'btn-large'
      onClick: btn.onClick
    if active
      props.className += ' active'
    if btn.value and item and item[btn.value]
      props.value = item[btn.value]
    button props, btn.label
