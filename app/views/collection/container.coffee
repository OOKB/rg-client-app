React = require 'react'
{p, div, ul, li, button} = require 'reactionary'

Row = require './row'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: @props.buttonsForInit
    searchTxt: @props.initState.searchTxt
    category: @props.initState.category
    pageSize: @props.initState.pageSize
    pageIndex: @props.initState.pageIndex

  render: ->
    p
      className: 'text-area',
        'Browse the collection by category below.'
    div
      className: 'collection',
        Row
          active: 'textile' == @state.category
          category: 'textile'
          collection: @props.collection
          initState: @props.initState
        Row
          active: 'passementerie' == @state.category
          category: 'passementerie'
          collection: @props.collection
          initState: @props.initState
        Row
          active: 'leather' == @state.category
          category: 'leather'
          collection: @props.collection
          initState: @props.initState
