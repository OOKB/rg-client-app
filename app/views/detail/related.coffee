React = require 'react'
{div, button, ul} = require 'reactionary'

module.exports = React.createClass
  getInitialState: ->
    pg: 0
    pgSize: 5

  propTypes:
    collection: React.PropTypes.object.isRequired


  handleUnitClick: (e) ->
    unit = e.target.value
    if e.preventDefault
      e.preventDefault()
    @setState unit: unit

  loadMetricRuler: ->
    unless @state.loadedMetric
      item = @props.model
      ruler_img = new Image()
      ruler_img.src = item.rulerPath.cm[@props.imgSize]
      console.log 'prefetch metric ruler ' + ruler_img.src
      @setState loadedMetric: true

  render: ->
    pages = Math.ceil(@props.collection.length / 5)
    if pages > 1
      pager_txt = (@state.pg+1) + ' / ' + pages
    else
      pager_txt = ''

    closeButton = button
      key: 'close'
      className: 'close plain'
      type: 'button',
        'X'

    header = div
      className: 'colors-header',
        pager_txt, closeButton

    relatedColorItems = []

    relatedColorsList = ul
      className: 'list-inline list'

    return div
      id: 'related-colors'
      className: 'hidden-xs',
        header
