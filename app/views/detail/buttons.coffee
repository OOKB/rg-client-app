React = require 'react'
{div, button, span, p, img, ul, li} = require 'reactionary'

Colors = require './related'
Rulers = require './ruler'
Notes = require './notes'

module.exports = React.createClass
  getInitialState: ->
    colorBoxView: false
    farView: false
    showRuler: true
    isRelated: false
    loadedLarge: false
    loadedXlarge: false
    showNotes: false

  toggleColorBoxView: ->
    @setState
      colorBoxView: !@state.colorBoxView
      showNotes: false

  handleUserInput: (newSt) ->
    @setState newSt

  render: ->
    item = @props.model
    # Data for the main image.
    ww = @props.windowWidth
    if ww < 640
      imgSize = 'small'
    else if ww < 1536
      imgSize = 'large'
    else
      imgSize = 'xlarge'

    unless item._file[imgSize]
      imgSize = 'xlarge'

    if @state.farView
      imgPath = item._file[imgSize].path_far
      imgClass = 'img-container pattern'
    else
      if @state.isRelated and !@state.loadedLarge and !@state.loadedXlarge
        mainImgSize = 'small'
      else
        mainImgSize = imgSize
      imgPath = item._file[mainImgSize].path
      imgClass = 'img-container large'
    if item.category == 'passementerie'
      imgClass += ' rotate-trim'
      imgStyle =
        marginTop: '-'+item._file[imgSize].height/2+'px'
    imgDiv = img
      className: imgClass
      alt: item.name
      src: imgPath
      style: imgStyle

    divs = []

    color_toggle_class = 'toggle-colors hidden-xs hidden-sm'
    if item.far
      color_toggle_class += ' with-far'
    if item.itemComments and item.summerSale
      color_toggle_class += ' with-notes'

    # Colors button.
    colorButtonClass = ''
    if @state.colorBoxView
      colorButtonClass += ' active'

    # Only show color button if there are related items.
    if @props.collection.length > 1 and not item.category == 'passementerie'
      divs.push div
        key: 'color-button'
        className: color_toggle_class,
          button
            onClick: @toggleColorBoxView
            className: colorButtonClass,
              'Colors'

    # Notes button.
    if item.itemComments and item.summerSale
      divs.push Notes
        notes: item.itemComments
        setParentState: @handleUserInput
        key: 'notes'
        showNotes: @state.showNotes

    if item.far
      divs.push div
        key: 'far-button'
        className: 'toggle-far hidden-xs',
          button
            onClick: => @setState farView: !@state.farView
            className: 'uppercase',
              span
                className: 'pattern',
                  'View Pattern'

    # Related colors.
    if @state.colorBoxView
      divs.push Colors
        initState: @props.initState
        key: 'related-colors'
        collection: @props.collection
        setContainerState: @props.onUserInput
        setParentState: @handleUserInput
        patternNumber: @props.patternNumber
        activeId: @props.activeId
        items: _.reject @props.collection.models, color_id: item.color_id
    # big-ol-image
    divs.push div
      key: 'main-image'
      className: imgSize,
        imgDiv

    # Ruler
    if @state.showRuler and not @state.farView and not item.category == 'passementerie'
      divs.push Rulers
        key: 'rulers'
        model: item
        imgSize: imgSize

    className = 'switcher'
    div className: className,
      divs
