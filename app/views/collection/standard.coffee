React = require 'react'
{p, div, ul, li, button} = require 'reactionary'
_ = require 'lodash'

Row = require './row'

module.exports = React.createClass

  render: ->
    props = @props
    categories = @props.initState.categories

    div
      className: 'standard',
        categories.map (cat) ->
          Row _.extend props,
            key: cat.id
            active: cat.active
            label: cat.label
