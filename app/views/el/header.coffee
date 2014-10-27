React = require 'react'
{header, h1, a, button} = require 'reactionary'

Menu = require './menu'

# Header div
module.exports = React.createClass
  getInitialState: ->
    forceInfo: false

  toggleInfo: ->
    @setState forceInfo: !@state.forceInfo

  handleMouseOver: ->
    if @props.initState.section == 'landing' and not @state.forceInfo
      @setState forceInfo: true

  handleMouseOut: ->
    if @props.initState.section == 'landing' and @state.forceInfo
      @setState forceInfo: false

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
    if app.me.loggedIn then headerClass += ' authenticated'
    mobileHideShow =
      button
        onClick: @toggleInfo
        className: className
        type: 'button',
          'Reveal Menu'

    # Always show the menu.
    navigation = Menu @props

    header
      onMouseOver: @handleMouseOver
      onMouseOut: @handleMouseOut
      className: headerClass,
        title, mobileHideShow, navigation
