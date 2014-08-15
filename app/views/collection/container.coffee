React = require 'react'
{p, div, ul, li, button} = require 'reactionary'

Row = require './row'

module.exports = React.createClass

  render: ->
    category = @props.initState.category
    div
      id: 'container-collection'
      className: 'collection',
        p
          className: 'text-area',
            'Browse the collection by category below.'
        Row
          active: 'textile' == category
          category: 'textile'
          label: 'Textiles'
          collection: @props.collection
          initState: @props.initState
        Row
          active: 'passementerie' == category
          category: 'passementerie'
          collection: @props.collection
          initState: @props.initState
        Row
          active: 'leather' == category
          category: 'leather'
          collection: @props.collection
          initState: @props.initState
