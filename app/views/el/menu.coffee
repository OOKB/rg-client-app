React = require 'react'
{div, nav, ul, li, a, i, input} = require 'reactionary'
_ = require 'lodash'

# Menu
module.exports = React.createClass
  getInitialState: ->
    searchIsActive: false
    tradeIsActive: app.me.loggedIn

  data: [
    id: 'about'
    title: 'About Us'
    href: '/about',
      id: 'collection'
      title: 'The Collection'
      href: '#collection',
        id: 'contact'
        title: 'Contact Us'
        href: '/contact',
          id: 'trade',
            id: 'search'
            title: 'Search'
  ]

  handleLogin: ->
    @setState tradeIsActive: true

  componentDidMount: ->
    app.me.on 'change:loggedIn', @handleLogin

  componentWillUnmount: ->
    app.me.off 'change:loggedIn', @handleLogin

  tradeData: ->
    if @props.initState.loggedIn or app.me.loggedIn
      data =
        id: 'trade'
        title: 'Trade Account'
        onMouseOver: => @setState tradeIsActive: true
        onClick: (e) =>
          @setState tradeIsActive: !@state.tradeIsActive
          #console.log 'trade'
        href: '#trade/account'
        value: 'trade'
        #onMouseOut:
        #childrenOut: =>
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
      if app.me.customerNumber == 'rogersandgoffigon'
        data.children.push
          id: 'no-img'
          title: 'No images'
          href: '#trade/pricelist/textile/50/x-no-img/p1'
        data.children.push
          id: 'invalid-id'
          title: 'Strange ID'
          href: '#trade/pricelist/textile/50/x-letter-ids/p1'
      data
    else
      id: 'trade'
      title: 'Trade Login'
      href: '#trade/login'

  handleChange: (event) ->
    newState =
      searchTxt: @refs.searchTxt.getDOMNode().value
      selectedFilters: {}
    unless @props.initState.category
      newState.category = 'textile'
    @props.setRouterState newState


  # Menu ul wrapper element.
  createNavEl: (children, name, onOut) ->
    ul
      onMouseOut: onOut
      className: name,
        children.map @createMenuEl

  # Menu li element.
  createMenuEl: (nav) ->
    unless nav.onClick
      nav.onClick = =>
        @setState
          tradeIsActive: app.me.loggedIn
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
      #itemIsActive = true
      child = @createNavEl(nav.children, 'sub-menu', nav.childrenOut)
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

  # Decide what search code to render.
  searchEl: (nav) ->
    if (@props.initState and @props.initState.searchTxt) or @state.searchIsActive
      search = @searchElActive()
    else
      search = i
        onMouseOver: () => @setState searchIsActive: true
        className: 'fa fa-search',
          nav.title
    li
      key: nav.id
      className: 'search-holder',
        search

  keyDown: (e) ->
    if e.key and e.key == 'Escape'
      s = @props.initState
      s.searchTxt = ''
      app.container.router.go s
    return

  # When active search text
  searchElActive: ->
    div
      onMouseOut: () => @setState searchIsActive: false
      className: 'form-inline'
      role: 'form'
      id: 'search-items',
        div
          className: 'form-group',
            input
              type: 'text'
              ref: 'searchTxt'
              value: @props.initState.searchTxt
              onChange: @handleChange
              onKeyDown: @keyDown
              className: 'form-control'
              name: 'item-search'
              placeholder: 'Enter search text'#'Search...'


  render: () ->
    nav
      className: 'menu',
        @createNavEl @data, 'top-menu'
