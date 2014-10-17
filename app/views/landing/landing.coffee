React = require 'react'
{div, img, ul, ol, li, a} = require 'reactionary'

_ = require 'lodash'

SlideItem = require './slide_item'
Indicators = require './indicators'

module.exports = React.createClass
  getInitialState: ->
    activeSlide: _.random 0, @data.length-1

  componentWillMount: ->
    app.items.clearFilters()

  componentDidUpdate: ->
    clearInterval @interval
    @interval = setInterval @next, 7000

  componentDidMount: ->
    @interval = setInterval @next, 7000

  componentWillUnmount: ->
    clearInterval @interval

  prev: ->
    if @state.activeSlide == 0
      @setState activeSlide: @data.length-1
    else
      @setState activeSlide: @state.activeSlide-1

  next: ->
    if @state.activeSlide == @data.length-1
      @setState activeSlide: 0
    else
      @setState activeSlide: @state.activeSlide+1

  data: [
    ['910079-02', '92208-03', '92210-02', '93701-05', '806017-01']
    ['92931-01', '938027-04', '91024-14', '92209-11', '92902-04']
    ['92535-02', '870004-10', '92705-12', '800002-09', '92201-05']
    ['750002-21', '750005-14', '92509-24', '91024-12', '890003-08']
    ['92530-01', '92207-01', '92535-01', '938026-05', '92209-12']
    ['92401-14', '910097-07', '890013-04', '750004-04', '890014-05']
    ['890015-02', '910034-08', '92902-06', '890018-05', '92702-12']
    ['750002-15', '750004-07', '92535-05', '92702-15', '92209-07']
    ['750005-19', '750002-09', '910065-03', '890018-07', '938006-02']
  ]

  render: ->
    activeSlide = @state.activeSlide
    slideIds = @data[activeSlide]
    slideItems = slideIds.map (id, i) -> SlideItem
      key: id
      model: app.items.get(id)
      i: i
    slideImg = "http://r_g.cape.io/beautyshots/"+(activeSlide+1)+"_1500.jpg"
    div
      id: 'landing',
        div className: 'slide',
          img
            src: slideImg
          ul
            className: 'image-map',
              slideItems
        Indicators
          slides: @data
          activeSlide: activeSlide
          setLanderState: (newSt) => @setState newSt

        a
          role: 'button'
          onClick: @prev
          className: 'left control',
            'Previous'
        a
          role: 'button'
          onClick: @next
          className: 'right control',
            'Next'
