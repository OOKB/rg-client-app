React = require 'react'
{div, ul, li, p, button, img, i, a, span} = require 'reactionary'
_ = require 'lodash'
SubCollection = require 'ampersand-subcollection'

Pager = require '../el/pager'

module.exports = React.createClass
  getInitialState: ->
    buttonsFor: ''
    windowWidth: window.innerWidth
    colorBoxView: false
    infoBoxView: false
    favBoxView: false

  setButtonsFor: (e) ->
    unless @props.threeUp or @state.colorBoxView
      @setState buttonsFor: e.target.id

  imgSize: ->
    if @props.threeUp == false or @props.initState.category == 'passementerie'
      return 'small'
    ww = @state.windowWidth
    if ww < 1280 or @props.initState.pgSize == 500
      return 'small'
    else
      return 'large'

  handleResize: (e) ->
    ww = window.innerWidth
    if ww % 5 == 0
      @setState windowWidth: ww

  componentDidMount: ->
    window.addEventListener 'resize', @handleResize

  componentWillUnmount: ->
    window.removeEventListener 'resize', @handleResize

  noResultsEl: ->
    txt1 = span
      className: 'category',
        @props.initState.category
    txt2 = span
      className: 'search-txt',
        @props.initState.searchTxt
    div
      className: 'search no-results',
        p 'No ', txt1, ' items match your search for ', txt2, '.'

  render: ->
    unless @props.collection.length
      return @noResultsEl()

    list = []
    buttonsFor = @props.threeUp or @state.buttonsFor
    imgSize = @imgSize()

    return ul
      className: 'list',
        list
