React = require 'react'
{div, img, ul} = require 'reactionary'

SlideItem = require './slide_item'

module.exports = React.createClass

  componentWillMount: ->
    app.items.clearFilters()

  render: ->
    slideIds = ['910079-02', '92208-03', '92210-02', '93701-05', '806017-01']
    slideItems = slideIds.map (id, i) -> SlideItem
      key: id
      model: app.items.get(id)
      i: i
    div
      id: 'landing',
        div className: 'slide',
          img
            src: "http://r_g.cape.io/beautyshots/1_1500.jpg"
          ul
            className: 'image-map',
              slideItems
