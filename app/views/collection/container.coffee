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
      topTxt = false
    else
      content = Standard props
      topTxt = 'Browse the collection by category below.'
    div
      id: 'container-collection'
      className: 'collection',
        p
          key: 'intro'
          className: 'text-area',
            topTxt
        content
