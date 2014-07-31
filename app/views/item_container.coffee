React = require 'react'
{div} = require 'reactionary'

SearchBar = require './item_search'
ProductTable = require './item_table'

module.exports = React.createClass
  getInitialState: ->
    filterText: ''
    collection: 'textile'

  handleUserInput: (filterText, collection) ->
    @setState
      filterText: filterText,
      collection: collection

  render: ->
    div {},
      SearchBar
        filterText: @state.filterText,
        collection: @state.collection,
        onUserInput: @handleUserInput
      ProductTable
        items: @props.items,
        filterText: @state.filterText,
        collection: @state.collection
