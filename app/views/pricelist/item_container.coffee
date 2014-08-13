React = require 'react'
{div} = require 'reactionary'
queryParam = require 'query-param-getter'

SearchBar = require './item_search'
ItemTable = require './item_table'
filterCollection = require '../../models/itemsFilter'

module.exports = React.createClass
  # The model prototype.
  getInitialState: ->
    searchTxt: @props.initState.searchTxt
    category: @props.initState.category
    summerSale: false
    pageSize: 50
    pageIndex: @props.initState.pageIndex
    patternNumber: null
    color_id: null
    display: 'pricelist'
    printing: false

  setQuery: (newState) ->
    ops =
      trigger: false
      replace: true
    destination = 'pricelist/'
    if newState.category
      # Change the browser history.
      ops.replace = false
      destination += newState.category + '/'
    else
      destination += @state.category + '/'

    if newState.searchTxt or typeof(newState.pageIndex) == 'number'
      q = newState.searchTxt or @state.searchTxt
      if q
        destination += q+'/'
      destination += 'p'+newState.pageIndex or '0'

    app.router.navigate destination, ops

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
      if search_string != @state.searchTxt
        # Reset pageIndex.
        new_state_obj.pageIndex = 0

    if new_state_obj.category and new_state_obj.category != @state.category
      new_state_obj.pageIndex = 0

    # Turn these into numbers.
    if new_state_obj.pageSize
      new_state_obj.pageSize = parseInt(new_state_obj.pageSize)
      if new_state_obj.pageSize != @state.pageSize
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
      @setState new_state_obj, window.print
    else
      @setState new_state_obj
    @setQuery new_state_obj

  render: ->
    div
      className: @state.category,
        SearchBar
          # The search bar accepts input so we need to pass a func that has this.
          onUserInput: @handleUserInput
          filter: @state
          total_pages: Math.ceil(@props.collection.filtered_length / @state.pageSize)
        ItemTable
          collection: @props.collection
          filter: @state
