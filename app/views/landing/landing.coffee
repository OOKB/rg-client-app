React = require 'react/addons'
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup
{div, img, ul, ol, li, a, button, p, h1, h2, strong, span} = require 'reactionary'
_ = require 'lodash'
Hammer = require 'hammerjs'

SlideItem = require './slide_item'
Indicators = require './indicators'

module.exports = React.createClass
  getInitialState: ->
    startingSlide = _.random 0, @data.length-1
    activeSlide: startingSlide
    prevSlide: 0
    showNotice: app.me.showNotice

  componentWillMount: ->
    app.items.clearFilters()

  componentDidUpdate: ->
    clearInterval @interval
    @interval = setInterval @next, 10000

  componentDidMount: ->
    reactElement = document.getElementById('react')
    @mc = new Hammer(reactElement)
    @mc.on 'swipeleft', @next
    @mc.on 'swiperight', @prev
    @interval = setInterval @next, 7000

  componentWillUnmount: ->
    clearInterval @interval
    @mc.off 'swipeleft', @next
    @mc.off 'swiperight', @prev

  prev: ->
    if @state.activeSlide == 0
      @setState
        activeSlide: @data.length-1
        prevSlide: @data.length
    else
      @setState
        activeSlide: @state.activeSlide-1
        prevSlide: @state.activeSlide

  next: ->
    if @state.activeSlide == @data.length-1
      @setState
        activeSlide: 0
        prevSlide: 0
    else
      @setState
        activeSlide: @state.activeSlide+1
        prevSlide: @state.activeSlide

  data: [
    ['91034-02',  '910100-04', '730005-02', '92219-02',  '910104-01']
    ['890023-02', '92935-03',  '92902-04',  '92934-07',  '730012-05']
    ['945003-07', '890007-02', '890020-04', '730010-02', '92705-12']
    ['750002-21', '750005-15', '810001-17', '944001-06', '806017-03']
    ['910101-01', '92207-01',  '730002-05', '96002-05',  '810001-13']
    ['750009-06', '910097-07', '750004-04', '806024-01', '890014-01']
    ['806025-03', '720001-08', '910034-08', '730006-04', '910104-07']
    ['92219-03',  '92209-07',  '92213-12',  '750004-07', '750002-26']
    ['92933-05',  '92934-01',  '93703-04',  '806026-01', '944001-03']
  ]
  handleNoticeClose: ->
    @setState showNotice: false
    app.me.showNotice = false

  render: ->
    activeSlide = @state.activeSlide
    slideIds = @data[activeSlide]
    slideItems = slideIds.map (id, i) -> SlideItem
      key: id
      model: app.items.get(id)
      i: i
    slideImg = "http://rogersandgoffigon.imgix.net/group/160516_rg_"+(activeSlide+1)+".jpg?w=1500"
    if @state.activeSlide < @state.prevSlide
      transitionClass = 'carousel-right'
    else
      transitionClass = 'carousel-left'
    noticeBoxClassName = if @state.showNotice then 'sorry-world' else 'hidden'

    div
      id: 'landing',
        div id: 'fixit-wrap',
          div className: 'slide',
            a
              href: '#collection',
                ReactCSSTransitionGroup
                  transitionName: transitionClass,
                    img
                      src: slideImg
                      key: slideImg
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

        div
          id: 'notice-box'
          className: noticeBoxClassName,
            a {href: '#collection/textile/96/850012/p1'},
              img
                src: 'http://rogersandgoffigon.imgix.net/banner/20180312-mottle.jpg?w=999'
                alt: 'Introducing Mottle.'
          button
            className: 'close'
            onClick: @handleNoticeClose,
              'Close'
