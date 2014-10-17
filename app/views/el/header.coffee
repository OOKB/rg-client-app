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
          href: '/#',
            'Rogers & Goffigon'
    className = 'toggle hidden-sm hidden-md hidden-lg'
    if @state.forceInfo then className += ' active'

    mobileHideShow =
      button
        onClick: @toggleInfo
        className: className
        type: 'button',
          'Reveal Menu'
    if window.innerWidth > 767 or @state.forceInfo
      navigation = Menu @props
    else
      navigation = false
    header {}, title, mobileHideShow, navigation
