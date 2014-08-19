React = require 'react'
{form, input, p, div, button, select, option, ul, li, a} = require 'reactionary'
_ = require 'lodash'

Pager = require '../el/pager'

# props
## onUserInput() - defined in item_container.

module.exports = React.createClass

  handleChange: (event) ->
    @props.onUserInput
      searchTxt: @refs.filterTextInput.getDOMNode().value

  handleCollectionClick: (e) ->
    collection_id = e.target.value
    if e.preventDefault
      e.preventDefault()
    @props.onUserInput
      category: collection_id

  render: ->
    v = @props.filter # see item_container.coffee for example object.
    #console.log 'search bar '+ v.pageIndex
    # Pager stuff.
    totalPages = @props.filter.totalPages

    sizes = Pager _.merge(@props.filter,
      setRouterState: @props.setRouterState
      el: 'sizes')
    count = Pager _.merge(@props.filter,
      setRouterState: @props.setRouterState
      el: 'count')
    pre = Pager _.merge(@props.filter,
      setRouterState: @props.setRouterState
      el: 'pre')
    next = Pager _.merge(@props.filter,
      setRouterState: @props.setRouterState
      el: 'next')

    if totalPages > 1
      pagerListItems = ul
        className: 'pager',
          pre, sizes, count, next
    else
      pagerListItems = ul
        className: 'pager',
          sizes, count

    return form {},
      input
        type:'text',
        placeholder:'Search...',
        value: v.searchTxt,
        ref:'filterTextInput',
        onChange: @handleChange
      div {},
        button
          className: if (v.category == 'textile') then 'active'
          onClick: @handleCollectionClick
          value: 'textile',
          'Textiles'
        button
          className: if (v.category == 'passementerie') then 'active'
          onClick: @handleCollectionClick
          value: 'passementerie',
          'Passementerie'
        button
          className: if (v.category == 'leather') then 'active'
          onClick: @handleCollectionClick
          value: 'leather',
          'Leather'
      # p {},
      #   input
      #     type: 'checkbox',
      #     value: v.summerSale,
      #     ref: 'summerSale',
      #     onChange: @handleChange
      #   'Only show summer sale products.'
      div
        className: 'pricelist-header',
          pagerListItems
