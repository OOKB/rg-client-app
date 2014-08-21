React = require 'react'
{p, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

Standard = require './standard'
Search = require './search'

module.exports = React.createClass

  render: ->
    category = @props.initState.category
    props = _.extend @props,
      threeUp: 3 == @props.initState.pgSize
      extraButtons: 'passementerie' == category or 3 == @props.initState.pgSize

    if @props.initState.searchTxt
      content = Search props
    else
      content = Standard props

    div
      id: 'container-collection'
      className: 'collection',
        p
          key: 'intro'
          className: 'text-area',
            'Browse the collection by category below.'
        content
