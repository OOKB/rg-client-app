React = require 'react'
{div, button, span, p, img, ul, li} = require 'reactionary'

Rulers = require './ruler'

module.exports = React.createClass
  getInitialState: ->
    colorBoxView: false
    colorBoxPg: 0
    farView: false
    pageSize: 5
    windowWidth: window.innerWidth
    showRuler: true

  handleResize: (e) ->
    @setState windowWidth: window.innerWidth

  componentDidMount: ->
    window.addEventListener 'resize', @handleResize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @handleResize

  render: ->
    item = @props.model
    cdn = '//img.rg.cape.io/'
    # Data for the main image.
    ww = @state.windowWidth
    if ww < 700
      imgSize = '640'
    else if ww < 1800
      imgSize = '1536'
    else
      imgSize = '2560'

    imgPath = cdn+'items/'+item.id+'/'
    if @state.farView
      imgPath += 'far/'+imgSize+'.jpg'
      imgClass = 'img-container pattern'
      imgDiv = ''
    else
      imgPath += imgSize+'.jpg'
      imgClass = 'img-container large'
      imgDiv = img
        className: 'img-large'
        alt: item.name
        src: imgPath

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

    if @state.colorBoxView
      pages = Math.ceil(@props.collection.length / 5)
      divs.push div
        key: 'related-colors'
        id: 'related-colors'
        className: 'hidden-xs'

    # big-ol-image
    divs.push div
      key: 'main-image'
      className: imgPath,
        imgDiv

    # Ruler
    if @state.showRuler and not @state.farView
      divs.push Rulers
        key: 'rulers'
        model: item
        cdn: cdn
        imgSize: imgSize

    div className: 'switcher',
      divs
