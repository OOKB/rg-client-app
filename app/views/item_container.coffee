React = require 'react'
{div} = require 'reactionary'

SearchBar = require './item_search'
ItemTable = require './item_table'

module.exports = React.createClass
  # The model prototype.
  getInitialState: ->
    searchTxt: ''
    category: 'textile'
    summerSale: false
    pageSize: 50
    pageIndex: 0
    patternNumber: null
    color_id: null
    display: 'pricelist'

  # Updates to the model.
  handleUserInput: (new_state_obj) ->
    # Process the input search string.
    if new_state_obj.searchTxt and new_state_obj.searchTxt != @state.searchTxt
      if new_state_obj.searchTxt.length > 1
        # Make sure the user input search text is lowercase.
        new_state_obj.searchTxt = new_state_obj.searchTxt.toLowerCase()
        # Make sure the text string is valid... Regex check.
      # Reset pageIndex.
      new_state_obj.pageIndex = @getInitialState().pageIndex

    if new_state_obj.category and new_state_obj.category != @state.category
      new_state_obj.pageIndex = @getInitialState().pageIndex

    # Turn these into numbers.
    if new_state_obj.pageSize
      new_state_obj.pageSize = parseInt(new_state_obj.pageSize)
    if new_state_obj.pageIndex
      new_state_obj.pageIndex = parseInt(new_state_obj.pageIndex)

    # Refilter the collection.
    @filterCollection(new_state_obj)
    # Set the new state.
    @setState new_state_obj

  filterCollection: (new_state) ->
    reset_collection = true
    unless new_state
      new_state = @state

    config = {}
    config.where =
      category: new_state.category or @state.category
    if new_state.searchTxt != ''
      text_to_search_for = new_state.searchTxt or @state.searchTxt
    else
      text_to_search_for = false
    if text_to_search_for
      config.filter = (model) ->
        model.searchStr.indexOf(text_to_search_for) > -1

    pageSize = new_state.pageSize or @state.pageSize
    if new_state.pageIndex != 0
      pageIndex = new_state.pageIndex or @state.pageIndex
    else
      pageIndex = 0

    config.limit = pageSize
    config.offset = pageIndex * pageSize
    #console.log config
    @props.collection.configure(config, reset_collection)

  render: ->
    # Filter the items on initial render.
    unless @isMounted()
      @filterCollection()
      console.log 'not mounted'
    div {},
      SearchBar
        # The search bar accepts input so we need to pass a func that has this.
        onUserInput: @handleUserInput
        filter: @state
        total_pages: Math.ceil(@props.collection.filtered_length / @state.pageSize)
      ItemTable
        collection: @props.collection
        filter: @state
