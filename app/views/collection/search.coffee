React = require 'react'
{p, div} = require 'reactionary'
_ = require 'lodash'

CategoryMenu = require '../el/category_menu'
Row = require './row'

module.exports = React.createClass

  render: ->
    if @props.collection.length
      div
        className: 'search',
          CategoryMenu @props.initState
          Row _.extend @props,
            key: @props.initState.category
            active: true
            label: 'Search Results'
    else
      div
        className: 'search no-results',
          p 'No items match your search for '+@props.initState.searchTxt+'.'
