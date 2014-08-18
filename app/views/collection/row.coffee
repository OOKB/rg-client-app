React = require 'react'
{div, ul, li, button, select, option, fieldset, label, input} = require 'reactionary'

Items = require './items'

module.exports = React.createClass
  getInitialState: ->
    showFilters: false
    filterTab: null

  categoryClick: (e) ->
    @props.setRouterState
      patternNumber: false
      id: false
      category: e.target.value

  pgResize: ->
    @props.setRouterState
      pgSize: @refs.setpgSize.getDOMNode().value

  toggleFilter: ->
    @setState
      filterTab: null
      showFilters: !@state.showFilters

  setFilterTab: (e) ->
    @setState
      filterTab: e.target.value

  sizeSelect: ->
    options = []
    pgSizes = @props.initState.pgSizes
    pgSize = @props.initState.pgSize
    pgSizes.forEach (size) ->
      options.push option
        key: size
        value: size,
          size
    li
      key: 'pageselect'
      className: 'pageselect',
        select
          ref: 'setpgSize'
          value: pgSize
          onChange: @pgResize
          type: 'select',
            options

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
    ops

  filterFields: (activeTab) ->
    fields = []
    fieldOps = @props.initState.filterFields[activeTab] or ['alpaca']

    fieldOps.forEach (filterOp) ->
      fields.push label
        key: filterOp
        className: 'checkbox-inline',
          input
            type: 'checkbox'
            value: filterOp,
              filterOp
    div
      className: 'filter-content',
        fieldset
          className: 'filter-attributes',
            div # Is this really required?
              className: 'moz-hack',
                fields

  filters: ->
    containerClass = 'btn-group'
    activeTab = @state.filterTab or @props.initState.filterOptions[0]
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
      className: 'filter text-left',
        div
          className: containerClass,
            button
              value: 'filter'
              type: 'button'
              onClick: @toggleFilter
              className: 'on-top uppercase plain dropdown-toggle',
                'filter'
            filterList

  render: ->
    headerList = []
    titleEl = li
      key: 'title'
      className: 'hug-center on-top',
        button
          className: 'uppercase'
          onClick: @categoryClick
          value: @props.key,
            @props.label

    if @props.active
      itemList = Items @props

      headerList.push li
        key: 'pagecount'
        className: 'pagecount hidden-xs',
          @props.initState.pageIndex + ' / ' + @props.initState.totalPages
      headerList.push @sizeSelect()
      headerList.push @filters()
      headerList.push titleEl
    else
      itemList = div {}
      headerList.push titleEl

    return div
      className: 'row'
      id: 'collection-row-'+@props.key,
        ul
          className: 'collection-controls',
            headerList
        itemList
