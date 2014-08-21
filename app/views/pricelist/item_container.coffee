React = require 'react'
{div} = require 'reactionary'

SearchBar = require './item_search'
ItemTable = require './item_table'

module.exports = React.createClass
  # The model prototype.
  getInitialState: ->
    summerSale: false
    color_id: null
    display: 'pricelist'
    printing: false

  # Updates to the model.
  handleUserInput: (new_state_obj) ->
    # console.log new_state_obj
    # Any state change that isn't a print will turn off printing.
    unless new_state_obj.printing
      new_state_obj.printing = false

    if new_state_obj.printing
      new_state_obj.pageIndex = 1
      new_state_obj.pgSize = 10000

    # Set the new state.
    if new_state_obj.printing
      @props.setRouterState new_state_obj, window.print
    else
      @props.setRouterState new_state_obj

  render: ->
    div
      id: 'container-pricelist'
      className: @props.initState.category,
        SearchBar
          # The search bar accepts input so we need to pass a func that has this.
          onUserInput: @handleUserInput
          setRouterState: @props.setRouterState
          filter: @props.initState
        div
          className: 'table-scroll',
            ItemTable
              collection: @props.collection
              filter: @props.initState
