React = require 'react'
{form, input, p, div, button} = require 'reactionary'

module.exports = React.createClass
  handleChange: ->
    # Call onUserInput() function defined in item_container.
    @props.onUserInput(
      @refs.filterTextInput.getDOMNode().value,
      @refs.summerSale.getDOMNode().checked
    )

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
          value: 'textile',
          'Textiles'
        button
          value: 'passementerie',
          'Passementerie'
        button
          value: 'leather',
          'Leather'
      p {},
        input
          type: 'checkbox',
          value: @props.summerSale,
          ref: 'summerSale',
          onChange: @handleChange
        'Only show summer sale products.'
