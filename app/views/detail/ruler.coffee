React = require 'react'
{div, button, span, p, img, ul, li} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    showRuler: true
    metric: false

  propTypes:
    model: React.PropTypes.object.isRequired
    imgSize: React.PropTypes.string.isRequired

  render: ->
    item = @props.model
    inchesClass = 'ruler-inches'
    cmClass = 'ruler-cm'
    if @state.metric
      unit = 'cm'
      imgClass = cmClass
      cmClass += ' active'
    else
      unit = 'inch'
      imgClass = inchesClass
      inchesClass += ' active'

    imgPath = item.rulerPath[unit][@props.imgSize]

    els = [] #elements
    # Ruler toggle.
    els.push ul
      key: 'ruler-toggle'
      className: 'ruler-toggle',
        li
          className: inchesClass,
            button className: 'uppercase',
              'Inches'
        li
          className: cmClass,
            button className: 'uppercase',
              'Centimeters'
    # Ruler image.
    els.push div
      key: 'rulers'
      className: 'rulers',
        img
          className: imgClass
          src: imgPath
          alt: imgClass

    return div className: 'ruler-wrap hidden-xs',
      els
