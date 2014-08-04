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
    if new_state_obj.searchTxt and new_state_obj.searchTxt.length > 1
      # Make sure the user input search text is lowercase.
      new_state_obj.searchTxt = new_state_obj.searchTxt.toLowerCase()
      # Make sure the text string is valid... Regex check.
      new_state_obj.pageIndex = @getInitialState().pageIndex
    # Define when the collection should be reset.

    # Refilter the collection.
    @filterCollection(new_state_obj)
    # Set the new state.
    @setState new_state_obj

  filterCollection: (new_state) ->
    reset_collection = false
    if new_state
      if new_state.category and new_state.category != @state.category
        reset_collection = true
    else
      new_state = @state

    pageSize = new_state.pageSize or @state.pageSize
    pageIndex = new_state.pageIndex or @state.pageIndex

    config = {}
    if new_state.category
      config.where =
        category: new_state.category
    if new_state.pageSize or reset_collection
      config.limit = pageSize
    if new_state.pageIndex or reset_collection
      config.offset = pageIndex * pageSize
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

      ItemTable
        collection: @props.collection
        filter: @state
