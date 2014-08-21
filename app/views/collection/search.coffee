React = require 'react'
{p, div, ul, li, button} = require 'reactionary'
_ = require 'lodash'

CategoryMenu = require '../el/category_menu'
Row = require './row'

module.exports = React.createClass

  render: ->
    #cat = _.find @props.initState.categories, active: true
    div
      className: 'search',
        CategoryMenu @props.initState
        Row _.extend @props,
          key: @props.initState.category
          active: true
          label: 'Search Results'
