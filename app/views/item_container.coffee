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
    # Set the new state.
    @setState new_state_obj

  render: ->

    div {},
      SearchBar
        # The search bar accepts input so we need to pass a func that has this.
        onUserInput: @handleUserInput
        filter: @state

      ItemTable
        collection: @props.collection
        filter: @state
