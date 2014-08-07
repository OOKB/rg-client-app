React = require 'react'
{nav, div, button, h3, p, span, ul, li} = require 'reactionary'

module.exports = React.createClass

  handleXclick: ->
    window.history.back()

  render: ->
    item = @props.model
    nav className: 'item-detail-header',
      div className: 'controls',
        ul
          li
            className: 'fav'
              button className: 'fav', '+'
          li className: 'close',
            button
              className: 'close'
              type: 'button'
              onClick: @handleXclick
              'area-hidden': 'true',
                'X'
        h3 'Details'
        button
          className: 'toggle'
          type: 'button'
      div className: 'item-detail-content',
        ul
          li className: 'name',
            h3 {}, item.label or item.category
            p {},
              span className: 'roman', item.name
              item.id
          li className: 'color',
            h3 'Color'
            p item.color
          li className: 'content',
            h3 'Content'
            p item.contents
          li className: 'repeat',
            h3 'Repeat'
            p item.repeat
          li className: 'width',
            h3 'Approx Width'
            p item.approx_width