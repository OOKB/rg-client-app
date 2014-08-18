React = require 'react'
{div, ul, li, button, select, option} = require 'reactionary'

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

  filterOps: ->
    ops = []
    activeTab = @state.filterTab or @props.initState.filterOptions[0]
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

  filters: ->
    containerClass = 'btn-group'
    if @state.showFilters
      filterList = ul
        className: 'filter-list'
        id: 'filter-list-'+@props.initState.category
        role: 'menu',
          @filterOps()
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
