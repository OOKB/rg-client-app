React = require 'react'
{div, ul, li, button} = require 'reactionary'

Items = require './items'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: @props.buttonsForInit
    searchTxt: @props.initState.searchTxt
    category: @props.initState.category
    pageSize: @props.initState.pageSize
    pageIndex: @props.initState.pageIndex

  render: ->
    div
      className: 'collection',
        div
          className: 'row'
          id: 'collection-row-textile',
            ul
              className: 'collection-controls',
                li
                  className: 'hug-center on-top',
                    button
                      className: 'uppercase'
                      value: 'textile',
                        'Textile'
            Items
              collection: @props.collection
              initState: @props.initState
        div
          className: 'row'
          id: 'collection-row-passementerie',
            button
              className: 'uppercase'
              value: 'passementerie',
                'Passementerie'
        div
          className: 'row'
          id: 'collection-row-leather',
            button
              className: 'uppercase'
              value: 'leather',
                'Leather'
