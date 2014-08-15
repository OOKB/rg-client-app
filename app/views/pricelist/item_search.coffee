React = require 'react'
{form, input, p, div, button, select, option, ul, li, a} = require 'reactionary'

# props
## onUserInput() - defined in item_container.

module.exports = React.createClass

  handleChange: (event) ->
    @props.onUserInput
      searchTxt: @refs.filterTextInput.getDOMNode().value
      pgSize: @refs.setpgSize.getDOMNode().value

  handleCollectionClick: (e) ->
    collection_id = e.target.value
    if e.preventDefault
      e.preventDefault()
    @props.onUserInput
      category: collection_id

  pageNext: (e) ->
    if @props.filter.pageIndex != @props.filter.totalPages-1
      @props.onUserInput
        pageIndex: @props.filter.pageIndex + 1

  pagePrevious: (e) ->
    if @props.filter.pageIndex != 0
      @props.onUserInput
        pageIndex: @props.filter.pageIndex - 1

  render: ->
    v = @props.filter # see item_container.coffee for example object.
    #console.log 'search bar '+ v.pageIndex
    # Pager stuff.
    totalPages = @props.filter.totalPages
    current_page = v.pageIndex + 1

    sizeSelect = li
      className: 'pageselect',
        select
          ref: 'setpgSize'
          value: v.pgSize
          onChange: @handleChange
          type: 'select',
            option
              value: '50',
                '50'
            option
              value: '100',
                '100'
            option
              value: '10000',
                'All'

    pgCount = li
      className: 'pagecount',
        current_page+ ' / ' + totalPages

    if totalPages > 1
      pager_previous_class = 'previous'
      if v.pageIndex == 0
        pager_previous_class += ' disabled'
      pager_next_class = 'next'

      if current_page == totalPages
        pager_next_class += ' disabled'

      pgLeft = li
        className: pager_previous_class,
          a
            className: 'left'
            role: 'button'
            ref: 'pager-previous'
            onClick: @pagePrevious,
              '&#60;'

      pgRight = li
        className: 'next',
          a
            className: 'right'
            role: 'button'
            ref: 'pager-next'
            onClick: @pageNext,
              '&#62;'

      pagerListItems = ul
        className: 'pager',
          pgLeft, sizeSelect, pgCount, pgRight
    else
      pagerListItems = ul
        className: 'pager',
          sizeSelect, pgCount

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
