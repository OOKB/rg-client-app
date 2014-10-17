React = require 'react'
{div, img, ul, ol, li, a} = require 'reactionary'

SlideItem = require './slide_item'

module.exports = React.createClass

  render: ->
    ol
      className: 'slide-indicators',
      li 'Need to auto output these'
      li 'Need to auto output these'
      li 'Need to auto output these'
      li
        className: 'active',
        'Need to auto output these'
