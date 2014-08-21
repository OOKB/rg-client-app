React = require 'react'
{p, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

Standard = require './standard'
Search = require './search'
Row = require './row'

module.exports = React.createClass

  render: ->
    category = @props.initState.category
    props = _.extend @props,
      threeUp: 3 == @props.initState.pgSize
      extraButtons: 'passementerie' == category or 3 == @props.initState.pgSize
    if @props.initState.searchTxt
      Search props
    else
      Standard props
