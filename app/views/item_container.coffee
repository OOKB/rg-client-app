React = require 'react'
{div} = require 'reactionary'
queryParam = require 'query-param-getter'

SearchBar = require './item_search'
ItemTable = require './item_table'

module.exports = React.createClass
  # The model prototype.
  getInitialState: ->
    q = @getQuery()
    searchTxt: q.searchTxt
    category: q.category
    summerSale: false
    pageSize: 50
    pageIndex: q.pageIndex
    patternNumber: null
    color_id: null
    display: 'pricelist'

  getQuery: ->
    q = {}
    q.category = switch queryParam('c')
      when 't' then 'textile'
      when 'textile' then 'textile'
      when 'p' then 'passementerie'
      when 'passementerie' then 'passementerie'
      when 'l' then 'leather'
      when 'leather' then 'leather'
      else 'textile'
    q.searchTxt = queryParam('q') || ''
    if q.searchTxt != ''
      q.searchTxt = @searchTxt q.searchTxt
    q.pageIndex = parseInt(queryParam('pg')) or 0
    q

  setQuery: (new_state) ->
    q = @getQuery()
    if new_state.category
      q.category = new_state.category
    pathname = location.pathname
    new_q = '?c=' + q.category
    if new_state.searchTxt
      new_q += '&q=' + new_state.searchTxt
    if typeof new_state.pageIndex == 'number'
      new_q += '&pg=' + new_state.pageIndex
    window.history.replaceState({}, '', pathname + new_q)

  searchTxt: (search_string) ->
    if typeof search_string == 'undefined'
      return @state.searchTxt or ''
    else if @state and @state.searchTxt and search_string == @state.searchTxt
      return search_string
    else
      # Make sure the user input search text is lowercase.
      search_string = search_string.toLowerCase()
      # Make sure the text string is valid... Regex check.
      search_string = search_string.replace(/[^a-z0-9-]/, '')
      return search_string

  # Updates to the model.
  handleUserInput: (new_state_obj) ->
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

    # Refilter the collection.
    @filterCollection(new_state_obj)
    # Set the new state.
    @setState new_state_obj
    @setQuery new_state_obj

  filterCollection: (new_state) ->
    reset_collection = true
    unless new_state
      new_state = @state

    config = {}
    config.where =
      category: new_state.category or @state.category
    if new_state.searchTxt
      config.filter = (model) ->
        model.searchStr.indexOf(new_state.searchTxt) > -1

    pageSize = new_state.pageSize or @state.pageSize
    if typeof new_state.pageIndex == 'number'
      pageIndex = new_state.pageIndex
    else
      pageIndex = @state.pageIndex

    config.limit = pageSize
    config.offset = pageIndex * pageSize
    #console.log config
    @props.collection.configure(config, reset_collection)

  render: ->
    # Filter the items on initial render.
    unless @isMounted()
      @filterCollection()
    div {},
      SearchBar
        # The search bar accepts input so we need to pass a func that has this.
        onUserInput: @handleUserInput
        filter: @state
        total_pages: Math.ceil(@props.collection.filtered_length / @state.pageSize)
      ItemTable
        collection: @props.collection
        filter: @state
