React = require 'react'
{div, nav, ul, li, a, i, input} = require 'reactionary'

# Menu
module.exports = React.createClass
  getInitialState: ->
    tradeIsActive: false

  componentDidMount: ->
    app.me.on 'change:customerNumber', => @forceUpdate()

  componentWillUnmount: ->
    app.me.off 'change:customerNumber', => @forceUpdate()

  tradeData: ->
    if @props.initState.loggedIn
      id: 'trade'
      title: 'Trade Account'
      onMouseOver: => @setState tradeIsActive: true
      onClick: => @setState tradeIsActive: !@state.tradeIsActive
      children: [
        id: 'projects'
        title: 'Projects'
        href: '#trade/projects',
          id: 'pricelist'
          title: 'Pricelist'
          href: '#trade/pricelist/textile/50/p1',
            id: 'summer'
            title: 'Summer Sale'
            href: '#trade/summer',
              id: 'account'
              title: 'Account'
              href: '#trade/account',
                id: 'logout'
                title: 'Logout'
                href: '#trade/logout'
                onClick: -> app.me.set customerNumber: null, token: null
      ]
    else
      id: 'trade'
      title: 'Trade Login'
      href: '#trade/login'

  render: () ->
    if app.me.loggedIn
      a
        href: 'app.html#trade/account',
          'Trade Account'
    else
      a
        href: 'app.html#trade/login',
          'Trade Login'
