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
    if e.target.value == 'pre' and @props.pageIndex != 1
      @props.setRouterState pageIndex: @props.pageIndex-1
    else if e.target.value == 'next' and @props.pageIndex != @props.totalPages
      @props.setRouterState pageIndex: @props.pageIndex+1

  setPgSize: ->
    @props.setRouterState
      pgSize: parseInt(@refs.setPgSize.getDOMNode().value)
      pageIndex: 1

  # Previous element.
  pre: ->
    props = @props
    if props.totalPages > 1
      liClass = 'previous'
      if props.pageIndex == 1
        liClass += ' disabled'
      return li
        key: 'previous'
        className: liClass,
          button
            value: 'pre'
            onClick: @setPgIndex
            className: 'left',
              '&#60;'
    else
      return false

  next: ->
    props = @props
    if props.totalPages > 1
      liClass = 'next'
      if props.pageIndex == props.totalPages
        liClass += ' disabled'
      return li
        key: 'next'
        className: liClass,
          button
            value: 'next'
            onClick: @setPgIndex
            className: 'next',
              '&#62;'
    else
      return false

  count: ->
    props = @props
    li
      key: 'pagecount'
      className: 'pagecount',
        props.pageIndex + ' / ' + props.totalPages

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
