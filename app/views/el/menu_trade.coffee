React = require 'react'
{div, nav, ul, li, a, i, input, span} = require 'reactionary'

# Menu
module.exports = React.createClass
  getInitialState: ->
    tradeIsActive: false

  componentDidMount: ->
    app.me.on 'change:customerNumber', => @forceUpdate()

  componentWillUnmount: ->
    app.me.off 'change:customerNumber', => @forceUpdate()

  tradeData:
    [
      id: 'projects'
      title: 'Projects'
      href: '/#trade/projects',
        id: 'pricelist'
        title: 'Pricelist'
        href: '/#trade/pricelist/textile/50/p1',
          # id: 'summer'
          # title: 'Summer Sale'
          # href: '/#trade/summer',
          id: 'account'
          title: 'Account'
          href: '/#trade/account',
            id: 'logout'
            title: 'Logout'
            href: '/#trade/logout'
            onClick: -> app.me.set customerNumber: null, token: null
    ]

  # Menu ul wrapper element.
  createNavEl: (children, name, onOut) ->
    ul
      className: name,
        children.map @createMenuEl

  # Menu li element.
  createMenuEl: (nav) ->
    unless nav.onClick
      nav.onClick = =>
        @setState
          tradeIsActive: false
          searchIsActive: false
    section = @props.initState and @props.initState.section
    if nav.id == 'trade' then nav = @tradeData()
    if nav.children and _.find(nav.children, id: section)
      itemIsActive = true
    else if section == nav.id
      itemIsActive = true
    else
      itemIsActive = false
    # Search has a special template.
    if nav.id == 'search'
      return @searchEl(nav)
    # Item has sub-items.
    if nav.children and (@state[nav.id+'IsActive'] or itemIsActive)
      itemIsActive = true
      child = @createNavEl(nav.children, 'sub-menu')
    else
      child = false
    liClass = nav.id
    if itemIsActive
      liClass += ' active'
    # Template.
    li
      key: nav.id
      onClick: nav.onClick
      onMouseOver: nav.onMouseOver
      onMouseOut: nav.onMouseOut
      className: liClass,
        a
          href: nav.href,
            nav.title
        child

  render: () ->
    if true
      children = @createNavEl(@tradeData, 'sub-menu', nav.childrenOut)
    else
      children = false
    if app.me.loggedIn
      span
        #onMouseOut: => @setState tradeIsActive: false
        className: 'active',
          a
            onMouseOver: => @setState tradeIsActive: true
            href: '/#trade/account',
              'Trade Account'
          children
    else
      a
        href: '/#trade/login',
          'Trade Login'
