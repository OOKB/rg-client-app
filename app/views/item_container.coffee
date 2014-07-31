React = require 'react'
{div} = require 'reactionary'

SearchBar = require './item_search'
ProductTable = require './item_table'

module.exports = React.createClass
  getInitialState: ->
    filterText: ''
    collection: 'textile'
    summerSale: false
    pageSize: 50
    pageIndex: 0

  handleUserInput: (new_state_obj) ->
    @setState new_state_obj

  render: ->
    div {},
      SearchBar
        onUserInput: @handleUserInput
        filterText: @state.filterText
        collection: @state.collection
        summerSale: @state.summerSale
        pageSize: @state.pageSize
        pageIndex: @state.pageIndex
      ProductTable
        items: @props.items
        filterText: @state.filterText
        collection: @state.collection
        summerSale: @state.summerSale
        pageSize: @state.pageSize
        pageIndex: @state.pageIndex
