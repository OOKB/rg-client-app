_ = require 'lodash'
React = require 'react'
{div, ul, li, button, select, option, fieldset, label, input, span, h3} = require 'reactionary'

Items = require './items'
Pager = require '../el/pager'
CloseButton = require '../el/button_close'

module.exports = React.createClass
  getInitialState: ->
    showFilters: (app.me.filterTab)
    filterTab: app.me.filterTab

  categoryClick: (e) ->
    # Standard hide or show.
    s = @props.initState
    if e.target.value == s.category
      # Probably trying to hide the filters.
      if @state.showFilters
        @setState showFilters: false
        app.me.filterTab = null
        return
      else
        s.category = null
    else
      s.category = e.target.value
      # Go to the page size the user wants.
      s.pgSize = app.me[e.target.value+'Size']
      s.pageIndex = 1
      # Unset filters when switching categories.
      s.selectedFilters = null
      app.me.filterTab = null
    app.container.router.go s

  handleToggleSort: ->
    s = @props.initState
    if s.order
      s.order = undefined
    else
      s.order = 'default'
    app.container.router.go s
    return

  toggleFilter: ->
    initTab = @props.initState.filterOptions[0]
    if @state.showFilters
      app.me.filterTab = null
      @setState
        filterTab: null
        showFilters: !@state.showFilters
    else
      app.me.filterTab = initTab
      @setState
        filterTab: initTab
        showFilters: true

  setFilterTab: (e) ->
    app.me.filterTab = e.target.value
    @setState
      filterTab: e.target.value

  setFilters: (e) ->
    s = @props.initState
    unless s.selectedFilters
      s.selectedFilters = {}
    filterFieldId = e.target.value
    isSelected = @refs[filterFieldId].getDOMNode().checked
    filters = s.selectedFilters[@state.filterTab] or []

    if isSelected
      filters.push filterFieldId
    else
      filters = _.without filters, filterFieldId
    s.selectedFilters[@state.filterTab] = filters
    # Reset the page index to the beginning.
    s.pageIndex = 1
    app.container.router.go s

  clearFilters: ->
    @props.setRouterState
      selectedFilters: {}

  # Toggle horizontal/virtical view.
  setPgSize: ->
    s = @props.initState
    if s.pgSize > 3
      s.pgSize = @props.initState.pgSizes[0]
    else
      s.pgSize = @props.initState.pgSizes[1]
    s.pageIndex = 1
    app.container.router.go s

  filterCategories: (activeTab) ->
    ops = []
    @props.initState.filterOptions.forEach (op) =>
      liClass = 'tab'
      if activeTab == op
        liClass += ' active'
      ops.push li
        key: op
        className: liClass,
          button
            onClick: @setFilterTab
            value: op,
              op
    # Clear button
    ops.push li
      key: 'clear'
      className: 'clear',
        button
          onClick: @clearFilters,
            'CLEAR ALL'
    ops

  filterFields: (activeTab) ->
    fields = []
    fieldOps = @props.initState.filterFields[activeTab]
    if @props.initState.selectedFilters and @props.initState.selectedFilters[activeTab]
      activeFields = @props.initState.selectedFilters[activeTab]
    else
      activeFields = []
    possibleFilters = @props.initState.possibleFilters[activeTab]
    #console.log activeFields
    fieldOps.forEach (filterOp) =>
      possibleItems = _.contains possibleFilters, filterOp
      isChecked = _.contains activeFields, filterOp
      labelClass = 'checkbox-inline'
      if isChecked
        labelClass += ' checked'
      filterEl = input
        type: 'checkbox'
        onChange: @setFilters
        ref: filterOp
        checked: isChecked
        value: filterOp,
          filterOp
      unless possibleItems or isChecked
        labelClass += ' disabled'
        #filterEl = span filterOp
      fields.push label
        key: filterOp
        className: labelClass,
          filterEl
    div
      className: 'filter-content',
        fieldset
          className: 'filter-attributes',
            div
              className: 'moz-hack',
                fields

  filters: ->
    containerClass = 'btn-group'
    activeTab = @state.filterTab
    if @state.showFilters
      closeFilters = CloseButton onClick: @toggleFilter
      filterList = ul
        className: 'filter-list'
        id: 'filter-list-'+@props.initState.category
        role: 'menu',
          @filterCategories activeTab
          @filterFields activeTab

      containerClass += ' open'
    else
      closeFilters = false
      filterList = false
    li
      key: 'filter'
      className: 'filter',
        closeFilters
        div
          className: containerClass,
            button
              value: 'filter'
              type: 'button'
              onClick: @toggleFilter
              className: 'dropdown-toggle',
                'filter'
                span
                  className: 'caret',
                    ''
            filterList

  arrangeToggle: ->
    if @props.initState.pgSize == 3
      buttonTxt = 'vertically'
    else
      buttonTxt = 'horizontally'
    li
      key: 'arrange'
      className: 'arrange',
        button
          onClick: @setPgSize
          lassName: 'thumbs plain uppgercase',
            'Arrange ' + buttonTxt
            span
              className: 'caret'

  render: ->
    headerList = []
    {order, searchTxt} = @props.initState
    if searchTxt
      titleEl = li
        className: 'search-title'
        key: 'title',
          h3 @props.label
    else
      titleEl = li
        key: 'title'
        className: 'collection-title',
          button
            onClick: @categoryClick
            value: @props.key,
              @props.label

    bottomPager = false
    activePager = @props.initState.totalPages > 1
    noItems = @props.collection.length == 0

    # New feature to toggle the type of sort for collection items.
    if order == 'default'
      sortTxt = 'Color Order'
    else
      sortTxt = 'Sort A-Z'
    toggleSort = li
      className: 'toggle-sort graphic-btn alpha',
        button
          onClick: @handleToggleSort,
            sortTxt

    # Issue #132. Don't show filter header items.
    if @props.active and @props.initState.section == 'summer' and noItems
      headerList.push titleEl
      itemList = Items @props
    else if @props.active
      itemList = Items @props
      if activePager
        headerList.push Pager _.merge(@props.initState, {el: 'pre', key: 'pre'})
      headerList.push Pager _.merge(@props.initState, {el: 'count', key: 'count'})
      unless @props.threeUp
        headerList.push Pager _.merge(@props.initState, {el: 'sizes', key: 'sizes'})
      # Filters
      headerList.push @filters()
      headerList.push titleEl

      # Toggle Sort button.
      headerList.push toggleSort

      if @props.initState.pgSizes[0] == 3
        headerList.push @arrangeToggle()
      if activePager
        headerList.push Pager _.merge(@props.initState, {el: 'next', key: 'next'})
        if @props.initState.pgSize > 3
          bottomPager = div
            className: 'collection-pager-bottom',
              ul
                className: 'collection-controls pager',
                  Pager _.merge(@props.initState, {el: 'pre', key: 'pre'})
                  Pager _.merge(@props.initState, {el: 'count', key: 'count'})
                  Pager _.merge(@props.initState, {el: 'next', key: 'next'})
    else
      itemList = false
      headerList.push titleEl
    rowClassName = 'row'
    if @props.active
      rowClassName += ' active'
    return div
      className: rowClassName
      id: 'collection-row-'+@props.key,
        ul
          className: 'collection-controls',
            headerList
        itemList
        bottomPager
