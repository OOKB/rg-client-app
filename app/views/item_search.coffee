React = require 'react'
{form, input, p, div, button} = require 'reactionary'

_ = require 'lodash'

# props
## onUserInput() - defined in item_container.

module.exports = React.createClass
  handleChange: ->
    @props.onUserInput
      filterText: @refs.filterTextInput.getDOMNode().value
      summerSale: @refs.summerSale.getDOMNode().checked

  handleCollectionClick: (collection_id, e) ->
    if e.preventDefault
      e.preventDefault()
    @props.onUserInput collection: collection_id

  render: ->
    form {},
      input
        type:'text',
        placeholder:'Search...',
        value: @props.filterText,
        ref:'filterTextInput',
        onChange: @handleChange
      div {},
        button
          className: if (@props.collection == 'textile') then 'active'
          onClick: _.partial @handleCollectionClick, 'textile'
          value: 'textile',
          'Textiles'
        button
          className: if (@props.collection == 'passementerie') then 'active'
          onClick: _.partial @handleCollectionClick, 'passementerie'
          value: 'passementerie',
          'Passementerie'
        button
          className: if (@props.collection == 'leather') then 'active'
          onClick: _.partial @handleCollectionClick, 'leather'
          value: 'leather',
          'Leather'
      p {},
        input
          type: 'checkbox',
          value: @props.summerSale,
          ref: 'summerSale',
          onChange: @handleChange
        'Only show summer sale products.'
