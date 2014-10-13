React = require 'react'
{input} = require 'reactionary'

# Sort number for admins.

module.exports = React.createClass

  propTypes:
    model: React.PropTypes.object.isRequired

  handleChange: (e) ->
    orderValue = parseInt @refs.adminOrder.getDOMNode().value
    if orderValue > 0 and orderValue != @props.model.order
      @props.model.order = orderValue
      app.me.updateItemOrder @props.model.id, orderValue
      @props.initState.setRouterState adminOrder: orderValue

  render: ->
    input
      className: 'item-order'
      type: 'text'
      ref: 'adminOrder'
      value: @props.model.order
      onChange: @handleChange
