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
    categories = [
      {id: 'textile', label: 'Textiles'}
      {id: 'passementerie', label: 'Passementerie'}
      {id: 'leather', label: 'Leather'}
    ]
    v = @props
    div
      className: 'collection-menu',
        categories.map (cat) =>
          button
            key: cat.id
            className: if (v.category == cat.id) then 'active'
            onClick: @handleCollectionClick
            value: cat.id,
              cat.label
