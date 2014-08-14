React = require 'react'
{div, ul, li, button} = require 'reactionary'

Items = require './items'

module.exports = React.createClass
  getInitialState: ->
    active: @props.active
    category: @props.category

  render: ->
    if @state.active
      itemList = Items
        collection: @props.collection
        initState: @props.initState
    else
      itemList = div {}

    return div
      className: 'row'
      id: 'collection-row-'+@state.category,
        ul
          className: 'collection-controls',
            li
              className: 'hug-center on-top',
                button
                  className: 'uppercase'
                  value: @state.category,
                    @state.category
        itemList
