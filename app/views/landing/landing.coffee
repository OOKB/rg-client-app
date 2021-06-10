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

  # Old data as of February 20 2019 these correspond with 160516_rg_X images on b2
  # data: [
  #   ['91034-02',  '910100-04', '730005-02', '92219-02',  '910104-01']
  #   ['890023-02', '92935-03',  '92902-04',  '92934-07',  '730012-05']
  #   ['945003-07', '890007-02', '890020-04', '730010-02', '92705-12']
  #   ['750002-21', '750005-15', '810001-17', '944001-06', '806017-03']
  #   ['910101-01', '92207-01',  '730002-05', '96002-05',  '810001-13']
  #   ['750009-06', '910097-07', '750004-04', '806024-01', '890014-01']
  #   ['806025-03', '720001-08', '910034-08', '730006-04', '910104-07']
  #   ['92219-03',  '92209-07',  '92213-12',  '750004-07', '750002-26']
  #   ['92933-05',  '92934-01',  '93703-04',  '806026-01', '944001-03']
  # ]

  # correspondes with 190219_rg_X images
  # data: [
  #  ['93301-01',  '730009-02', '806017-12', '730015-01', '910102-04']
  #  ['890033-04', '750004-01', '92537-01',  '730014-02', '730012-01']
  #  ['890031-04', '850012-01', '750013-22', '812010-02', '750014-12']
  #  ['92209-08',  '750002-01', '96007-12',  '910100-03', '91042-02']
  #  ['750013-03', '96008-04',  '990001-03', '91034-09',  '890018-06']
  #  ['730017-09', '91044-03',  '890032-02', '890012-04', '92536-02']
  #  ['890037-02', '945001-03', '96007-13',  '92509-11',  '850012-11']
  #  ['92213-06',  '960003-07', '750015-15', '92937-04',  '720001-05']
  #  ['730018-01', '',          '930001-01', '945003-01', '740046-02']
  #]

  # correspondes with 020201112 images
  data: [
    ['730006-01', '92224-01',  '710015-03', '91047-04',  '945009-06']
    ['806031-01', '700003-01', '806032-01', '740060-01', '92222-01' ]
    ['710019-02', '710015-01', '945011-11', '740056-01', '890040-01']
    ['93706-05',  '710017-01', '91048-07',  '740039-05', '700003-03']
    ['938034-04', '730016-05', '890037-03', '890039-04', '92225-04' ]
    ['945004-06', '945009-03', '890036-03', '92225-03',  '945006-03']
    ['945008-04', '710017-08', '945004-09', '938034-05', '760002-02']
    ['945004-04', '945010-04', '92225-01',  '700003-05', '91048-08' ]
    ['930005-02', '945004-03', '730016-02', '945007-03', '740058-03']
    ['938034-16', '890036-04', '890037-06', '945006-02', '92225-05' ]
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
    slideImg = "https://rogersandgoffigon.imgix.net/group/020201112_rg_"+(activeSlide+1)+".jpg?w=1500"
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
            a {href: '#collection/textile/96/930006/p1'},
              img
                src: 'https://rogersandgoffigon.imgix.net/banner/020210610-EggCups.jpg?w=1111'
                alt: 'Introducing Egg Cups, a wide-width, sheer, with unique weave and texture, available in two colorways'
          button
            className: 'close'
            onClick: @handleNoticeClose,
              'Close'
