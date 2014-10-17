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
    isLanding = @props.initState.section == 'landing'
    showMenu = window.innerWidth > 767 and not isLanding
    title =
      h1 {},
        a
          href: '/#',
            'Rogers & Goffigon'
    headerClass = 'closed'
    className = 'toggle'
    if showMenu
      className += ' hidden-sm hidden-md hidden-lg'
      headerClass = ' open'
    if @state.forceInfo then className += ' active'
    if @state.forceInfo then headerClass = 'open'

    mobileHideShow =
      button
        onClick: @toggleInfo
        className: className
        type: 'button',
          'Reveal Menu'
    if showMenu or @state.forceInfo
      navigation = Menu @props
    else
      navigation = false
    header className: headerClass, title, mobileHideShow, navigation
