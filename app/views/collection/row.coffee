_ = require 'lodash'
React = require 'react'
{div, ul, li, button, select, option, fieldset, label, input, span, h3} = require 'reactionary'

Items = require './items'
Pager = require '../el/pager'

module.exports = React.createClass
  getInitialState: ->
    showFilters: false
    filterTab: null

  categoryClick: (e) ->
    newCategory = e.target.value
    if newCategory == @props.initState.category
      if @state.showFilters == true
        @setState
          showFilters: false
        return
      newCategory = null

    @props.setRouterState
      patternNumber: false
      id: false
      category: newCategory
      selectedFilters: {}

  toggleFilter: ->
    if @state.showFilters == false
      @setState
        filterTab: @props.initState.filterOptions[0]
        showFilters: true
    else
      @setState
        filterTab: null
        showFilters: !@state.showFilters

  setFilterTab: (e) ->
    @setState
      filterTab: e.target.value

  setFilters: (e) ->
    filterFieldId = e.target.value
    isSelected = @refs[filterFieldId].getDOMNode().checked
    selected = _.cloneDeep @props.initState.selectedFilters
    if isSelected
      unless selected[@state.filterTab]
        selected[@state.filterTab] = []
      selected[@state.filterTab].push filterFieldId

    else
      selected[@state.filterTab] = _.without selected[@state.filterTab], filterFieldId

    @props.setRouterState
      selectedFilters: selected
    #console.log @state.filterTab + ': ' + filterFieldId + ' is ' + isSelected

  clearFilters: ->
    @props.setRouterState
      selectedFilters: {}

  setPgSize: ->
    if @props.initState.pgSize > 3
      @props.setRouterState pgSize: @props.initState.pgSizes[0]
    else
      @props.setRouterState pgSize: @props.initState.pgSizes[1]

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
    fieldOps = @props.initState.filterFields[activeTab] or ['alpaca']
    activeFields = @props.initState.selectedFilters[activeTab]
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
      filterList = ul
        className: 'filter-list'
        id: 'filter-list-'+@props.initState.category
        role: 'menu',
          @filterCategories activeTab
          @filterFields activeTab

      containerClass += ' open'
    else
      filterList = ''
    li
      key: 'filter'
      className: 'filter',
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
    if @props.initState.searchTxt
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
    if @props.active
      activePager = @props.initState.totalPages > 1
      itemList = Items @props
      if activePager
        headerList.push Pager _.merge(@props.initState, {el: 'pre', key: 'pre'})
      headerList.push Pager _.merge(@props.initState, {el: 'count', key: 'count'})
      headerList.push Pager _.merge(@props.initState, {el: 'sizes', key: 'sizes'})
      headerList.push @filters()
      headerList.push titleEl
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
      itemList = div {}
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
