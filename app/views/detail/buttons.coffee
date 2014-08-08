React = require 'react'
{div, button, span, p, img, ul, li} = require 'reactionary'

Colors = require './related'
Rulers = require './ruler'

module.exports = React.createClass
  getInitialState: ->
    colorBoxView: false
    farView: false
    windowWidth: window.innerWidth
    showRuler: true

  handleResize: (e) ->
    @setState windowWidth: window.innerWidth

  componentDidMount: ->
    window.addEventListener 'resize', @handleResize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @handleResize

  toggleColorBoxView: ->
    @setState colorBoxView: !@state.colorBoxView

  handleUserInput: (newSt) ->
    @setState newSt

  render: ->
    item = @props.model
    # Data for the main image.
    ww = @state.windowWidth
    if ww < 640
      imgSize = 'small'
    else if ww < 1536
      imgSize = 'large'
    else
      imgSize = 'xlarge'

    if @state.farView
      imgPath = item._file[imgSize].path_far
      imgClass = 'img-container pattern'
      imgDiv = ''
    else
      imgPath = item._file[imgSize].path
      imgClass = 'img-container large'
      imgDiv = img
        className: 'img-large'
        alt: item.name
        src: imgPath

    divs = []

    color_toggle_class = 'toggle-colors hidden-xs'
    if item.far
      color_toggle_class += ' with-far'

    # Colors button.
    colorButtonClass = ''
    if @state.colorBoxView
      colorButtonClass += ' active'
    divs.push div
      key: 'color-button'
      className: color_toggle_class,
        button
          onClick: @toggleColorBoxView
          className: colorButtonClass,
            'Colors'

    if item.far
      divs.push div
        key: 'far-button'
        className: 'toggle-far hidden-xs',
          button className: 'uppercase',
            span className: 'pattern',
              'View Pattern'

    # Related colors.
    if @state.colorBoxView
      divs.push Colors
        key: 'related-colors'
        collection: @props.collection
        setContainerState: @props.onUserInput
        setParentState: @handleUserInput

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
        imgSize: imgSize

    div className: 'switcher',
      divs
