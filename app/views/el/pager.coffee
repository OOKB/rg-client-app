{li, button, select, option, p, span} = require 'reactionary'
React = require 'react'

module.exports = React.createClass

  propTypes:
    pageIndex: React.PropTypes.number.isRequired
    pgSize: React.PropTypes.number.isRequired
    totalPages: React.PropTypes.number.isRequired
    setRouterState: React.PropTypes.func.isRequired
    pgSizes: React.PropTypes.arrayOf(React.PropTypes.number).isRequired

  setPgIndex: (e) ->
    if e.preventDefault
      e.preventDefault()
    if e.target.value == 'pre'
      if @props.pageIndex != 1
        @props.setRouterState pageIndex: @props.pageIndex-1
      else if @props.pgSize == 3
        @props.setRouterState pageIndex: @props.totalPages
    else if e.target.value == 'next'
      if @props.pageIndex != @props.totalPages
        @props.setRouterState pageIndex: @props.pageIndex+1
      else if @props.pgSize == 3
        @props.setRouterState pageIndex: 1

  setPgSize: ->
    s = @props
    s.pgSize = parseInt(@refs.setPgSize.getDOMNode().value)
    s.pageIndex = 1
    app.container.router.go s

  # Previous element.
  pre: ->
    props = @props
    if props.totalPages > 1
      liClass = 'previous'
      if props.pageIndex == 1 and props.pgSize != 3
        liClass += ' disabled'
      return li
        key: 'previous'
        className: liClass,
          button
            value: 'pre'
            onClick: @setPgIndex
            className: 'left',
              '<'
    else
      return false

  next: ->
    props = @props
    if props.totalPages > 1
      liClass = 'next'
      if props.pageIndex == props.totalPages and props.pgSize != 3
        liClass += ' disabled'
      return li
        key: 'next'
        className: liClass,
          button
            value: 'next'
            onClick: @setPgIndex
            className: 'next',
              '>'
    else
      return false

  count: ->
    props = @props
    if props.totalPages
      li
        key: 'pagecount'
        className: 'pagecount',
          props.pageIndex + ' / ' + props.totalPages
    else
      false

  sizes: ->
    props = @props
    options = []
    pgSizes = props.pgSizes
    pgSize = props.pgSize
    pgSizes.forEach (size) ->
      label = if 10000 == size then 'All' else size
      options.push option
        key: size
        value: size,
          label
    li
      key: 'pageselect'
      className: 'pageselect',
        span
          className: 'uppercase',
            'View '
        select
          ref: 'setPgSize'
          value: pgSize
          onChange: @setPgSize
          type: 'select',
            options

  render: ->
    if @[@props.el]
      component = @[@props.el]()
    else
      component = p 'Hello there! Unfortunately our application is broken. Missing element function.'+@props.el
