React = require 'react'
{div, table, tbody, tr, td, button, h3, p, span} = require 'reactionary'

module.exports = React.createClass

  render: ->
    item = @props.model
    console.log item.toJSON()
    div className: 'item-detail',
      table className: 'itemoverlay-header '+item.category,
        tbody {},
          tr {},
            td
              className: 'fav text-left'
              width: '29',
                button className: 'plain fav', '+'
            td className: 'name',
              h3 {}, item.label or item.category
              p {},
                span className: 'roman', item.name
                item.id
            td className: 'color',
              h3 'Color'
              p item.color
            td className: 'content',
              h3 'Content'
              p item.contents
            td className: 'repeat',
              h3 'Repeat'
              p item.repeat
            td className: 'width',
              h3 'Approx Width'
              p item.approx_width
            td className: 'close text-left',
              button
                className: 'close plain'
                type: 'button'
                'area-hidden': 'true',
                'X'
