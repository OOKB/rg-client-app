React = require 'react'
{div, ul, li, button, img, i} = require 'reactionary'

module.exports = React.createClass
  render: ->
    list = []
    @props.collection.forEach (item, index) ->
      list.push li
        key: item.id,
          img
            src: item._file.small.path
          div
            className: 'item-icons',
              button
                className: 'item-colors',
                  'Colors'
              button
                className: 'item-favorite',
                  '+'
              button
                className: 'item-details',
                  i
                    className: 'fa fa-align-justify',
                      'i'

    div
      className: 'threeup'
      id: 'products',
        ul
          className: 'list slider',
            list
