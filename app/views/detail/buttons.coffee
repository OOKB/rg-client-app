React = require 'react'
{div, button, span, p} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    color_box_view: false
    color_box_pg: 0
    far_view: false
    id: '01'

  render: ->
    item = @props.model
    #console.log item.toJSON()
    divs = []

    color_toggle_class = 'toggle-colors hidden-xs'
    if item.far
      color_toggle_class += ' with-far'

    divs.push div
      key: 'color-button'
      className: color_toggle_class,
        button className: 'uppercase', 'Colors'
    if item.far
      divs.push div
        key: 'far-button'
        className: 'toggle-far hidden-xs',
          button className: 'uppercase',
            span className: 'pattern',
              'View Pattern'

    div className: 'switcher',
      divs
