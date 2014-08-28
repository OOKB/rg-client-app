React = require 'react'
{div, nav, ul, li, a, i, form, input} = require 'reactionary'
_ = require 'lodash'

# Menu
module.exports = React.createClass
  getInitialState: ->
    searchIsActive: false
    tradeIsActive: false

  data: [
    id: 'about'
    title: 'About Us'
    href: '#',#'/about',
      id: 'collection'
      title: 'The Collection'
      href: '#collection/textile/3/p1',
        id: 'contact'
        title: 'Contact Us'
        href: '#',
          id: 'trade',
            id: 'search'
            title: 'Search'
  ]

  tradeData: ->
    if @props.initState.loggedIn
      id: 'trade'
      title: 'Trade Account'
      onMouseOver: => @setState tradeIsActive: true
      onClick: => @setState tradeIsActive: !@state.tradeIsActive
      #onMouseOut:
      #childrenOut: =>
      children: [
        id: 'projects'
        title: 'Projects'
        href: '#',
          id: 'pricelist'
          title: 'Pricelist'
          href: '#trade/pricelist/textile/50/p1',
            id: 'summer-sale'
            title: 'Summer Sale'
            href: '#trade/summer-sale',
              id: 'account'
              title: 'Account'
              href: '#trade/account',
                id: 'logout'
                title: 'Logout'
                href: '#'
                onClick: -> app.me.customerNumber = null
      ]
    else
      id: 'trade'
      title: 'Trade Login'
      href: '#trade/login'

  handleChange: (event) ->
    @props.setRouterState
      searchTxt: @refs.searchTxt.getDOMNode().value

  # Menu ul wrapper element.
  createNavEl: (children, name, onOut) ->
    ul
      onMouseOut: onOut
      className: name,
        children.map @createMenuEl

  # Menu li element.
  createMenuEl: (nav) ->
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

  # When active search text
  searchElActive: ->
    form
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
              className: 'form-control'
              name: 'item-search'
              placeholder: 'Enter search text'#'Search...'


  render: () ->
    nav
      className: 'menu',
        @createNavEl @data, 'top-menu'
