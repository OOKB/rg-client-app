React = require 'react'
{input} = require 'reactionary'

# Sort number for admins.

module.exports = React.createClass
  getInitialState: ->
    itemOrder: @props.model.order

  propTypes:
    model: React.PropTypes.object.isRequired

  handleChange: (e) ->
    orderValue = parseInt @refs.adminOrder.getDOMNode().value
    if orderValue and orderValue > 0
      @setState itemOrder: orderValue
    else
      @setState itemOrder: ''

  saveChanges: ->
    orderValue = @state.itemOrder
    @props.model.order = orderValue
    app.me.updateItemOrder @props.model.id, orderValue
    @props.initState.setRouterState adminOrder: orderValue

  keyDown: (e) ->
    if e.key and e.key == 'Enter'
      @saveChanges()
    return

  render: ->
    input
      className: 'item-order'
      type: 'text'
      ref: 'adminOrder'
      value: @state.itemOrder
      onChange: @handleChange
      onKeyDown: @keyDown
