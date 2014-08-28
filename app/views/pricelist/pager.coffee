React = require 'react'
{form, input, p, div, button, select, option, ul, li, a} = require 'reactionary'
_ = require 'lodash'

Pager = require '../el/pager'

module.exports = React.createClass

  render: ->
    v = @props.initState
    totalPages = v.totalPages
    if @props.hideSizes
      sizes = false
    else
      sizes = Pager _.extend(v,
        setRouterState: v.setRouterState
        key: 'sizes'
        el: 'sizes')
    count = Pager _.extend(v,
      setRouterState: v.setRouterState
      key: 'count'
      el: 'count')
    pre = Pager _.extend(v,
      setRouterState: v.setRouterState
      key: 'pre'
      el: 'pre')
    next = Pager _.extend(v,
      setRouterState: v.setRouterState
      key: 'next'
      el: 'next')

    if totalPages > 1
      ul
        className: 'pager',
          pre, sizes, count, next
    else
      ul
        className: 'pager',
          sizes, count
