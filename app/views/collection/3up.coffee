React = require 'react'
{div, ul, li, span, img} = require 'reactionary'

module.exports = React.createClass
  render: ->
    list = []
    for i in [0..2]
      item = @props.collection.at(i)
      list.push li
        key: item.id,
          img
            src: item._file.small.path

    div
      className: 'threeup'
      id: 'products',
        ul
          className: 'list slider',
            list
