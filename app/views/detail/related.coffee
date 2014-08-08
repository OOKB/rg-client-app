React = require 'react'
{div, button, ul, li, a, img, i} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    pg: 0
    pgSize: 5
    pages: Math.ceil(@props.collection.length / 5)
    prevActive: false
    nextActive: true

  propTypes:
    collection: React.PropTypes.object.isRequired

  handleColorClick: (e) ->
    color_id = e.target.id
    href = e.target.parentElement.hash.substr(1)
    if e.preventDefault
      e.preventDefault()
    #console.log href
    app.router.navigate(href, {replace: true})
    @props.setContainerState color_id: color_id

  handleUnitClick: (e) ->
    unit = e.target.value
    if e.preventDefault
      e.preventDefault()
    @setState unit: unit

  handleXclick: (e) ->
    if e.preventDefault
      e.preventDefault()
    @setState colorBoxView: false

  handleNextClick: (e) ->
    if e.preventDefault
      e.preventDefault()
    if @state.pg < @state.pages
      @setState pg: pg+1

  handlePrevClick: (e) ->
    if e.preventDefault
      e.preventDefault()
    if @state.pg > 0
      @setState pg: pg-1

  render: ->
    itemCount = @props.collection.length
    pages = @state.pages
    if pages > 1
      pager = true
      pager_txt = (@state.pg+1) + ' / ' + pages
    else
      pager_txt = ''

    closeButton = button
      key: 'close'
      className: 'close'
      onClick: @handleXclick
      type: 'button',
        'X'

    # Header
    header = div
      className: 'colors-header',
        pager_txt, closeButton
    offset = @state.pg * @state.pgSize
    limit = (@state.pg + 1) * @state.pgSize
    pageItems = @props.collection.models.slice(offset, limit)
    relatedColorItems = []
    pageItems.forEach (item) =>
      relatedColorItems.push li
        key: item.id
        className: 'related-item',
          a
            onClick: @handleColorClick
            href: item.detail,
              img
                id: item.color_id
                src: item._file.small.path
                alt: item.color

    relatedColorsList = ul
      className: 'list-inline list',
        relatedColorItems

    # Colors row.
    if pager
      relatedColorsRow = div {},
          button
            onClick: @handlePrevClick
            className: 'left plain controls rel-previous',
              i className: 'fa fa-angle-left fa-2x'
          relatedColorsList
          button
            onClick: @handleNextClick
            className: 'right plain controls rel-next',
              i className: 'fa fa-angle-right fa-2x'
    else
      relatedColorsRow = relatedColorsList

    if itemCount < 5
      colorsClass = 'hidden-xs size-'+itemCount
    else
      colorsClass = 'hidden-xs size-5'
    if pager
      colorsClass += ' pager'
    return div
      id: 'related-colors'
      className: colorsClass,
        header, relatedColorsRow
