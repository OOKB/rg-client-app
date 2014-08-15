React = require 'react'
{div} = require 'reactionary'

SearchBar = require './item_search'
ItemTable = require './item_table'
filterCollection = require '../../models/itemsFilter'

module.exports = React.createClass
  # The model prototype.
  getInitialState: ->
    summerSale: false
    color_id: null
    display: 'pricelist'
    printing: false

  searchTxt: (search_string) ->
    if typeof search_string == 'undefined'
      return @state.searchTxt or ''
    else if @state and @state.searchTxt and search_string == @state.searchTxt
      return search_string
    else
      # Make sure the user input search text is lowercase.
      search_string = search_string.toLowerCase()
      # Make sure the text string is valid... Regex check.
      search_string = search_string.replace(/[^a-z0-9-\s]/, '')
      return search_string

  # Updates to the model.
  handleUserInput: (new_state_obj) ->
    # console.log new_state_obj
    # Any state change that isn't a print will turn off printing.
    unless new_state_obj.printing
      new_state_obj.printing = false

    # Process the input search string.
    if search_string = @searchTxt new_state_obj.searchTxt
      new_state_obj.searchTxt = search_string
      if search_string != @props.initState.searchTxt
        # Reset pageIndex.
        new_state_obj.pageIndex = 0

    if new_state_obj.category and new_state_obj.category != @props.initState.category
      new_state_obj.pageIndex = 0

    # Turn these into numbers.
    if new_state_obj.pageSize
      new_state_obj.pageSize = parseInt(new_state_obj.pageSize)
      if new_state_obj.pageSize != @props.initState.pageSize
        new_state_obj.pageIndex = 0
    if new_state_obj.pageIndex
      new_state_obj.pageIndex = parseInt(new_state_obj.pageIndex)

    if new_state_obj.printing
      new_state_obj.pageIndex = 0
      new_state_obj.pageSize = 10000

    # Refilter the collection.
    filterCollection(@props.collection, new_state_obj, @state)
    # Set the new state.
    if new_state_obj.printing
      @props.setRouterState new_state_obj, window.print
    else
      @props.setRouterState new_state_obj

  render: ->
    div
      className: @state.category,
        SearchBar
          # The search bar accepts input so we need to pass a func that has this.
          onUserInput: @handleUserInput
          filter: @props.initState
          total_pages: Math.ceil(@props.collection.filtered_length / @state.pageSize)
        ItemTable
          collection: @props.collection
          filter: @props.initState
