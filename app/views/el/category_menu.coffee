React = require 'react'
{div, button} = require 'reactionary'

module.exports = React.createClass

  handleCollectionClick: (e) ->
    collection_id = e.target.value
    if e.preventDefault
      e.preventDefault()
    @props.setRouterState
      category: collection_id
      pageIndex: 1

  render: ->
    v = @props
    div
      className: 'collection-menu',
        v.categories.map (cat) =>
          button
            key: cat.id
            className: if cat.active then 'active'
            onClick: @handleCollectionClick
            value: cat.id,
              cat.label
