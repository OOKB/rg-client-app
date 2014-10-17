React = require 'react'
{ol, li, button} = require 'reactionary'

module.exports = React.createClass

  render: ->
    indicators = @props.slides.map (slide, i) =>

      if i == @props.activeSlide
        className = 'active'
      else
        className = 'goto-'+i
      li
        key: 'indicator'+i
        className: className,
          button
            onClick: => @props.setLanderState
              activeSlide: i
              prevSlide: @props.activeSlide
            value: i,
              i
    ol
      className: 'slide-indicators',
        indicators
