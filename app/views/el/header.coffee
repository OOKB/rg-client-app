React = require 'react'
{header, h1, a, button} = require 'reactionary'

Menu = require './menu'

# Header div
module.exports = React.createClass
  getInitialState: ->
    forceInfo: false

  toggleInfo: ->
    @setState forceInfo: !@state.forceInfo

  render: () ->
    title =
      h1 {},
        a
          href: '/',
            'Rogers & Goffigon'
    mobileHideShow =
      button
        onClick: @toggleInfo
        className: 'toggle hidden-md hidden-lg'
        type: 'button',
          'Reveal Menu'
    if window.innerWidth > 991 or @state.forceInfo
      navigation = Menu @props
    else
      navigation = false
    header {}, title, mobileHideShow, navigation
