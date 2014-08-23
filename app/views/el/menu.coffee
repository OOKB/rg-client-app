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
          id: 'trade'
          title: 'Trade Login'
          children: [
            id: 'projects'
            title: 'Projects'
            href: '#',
              id: 'pricelist'
              title: 'Pricelist'
              href: '#pricelist/textile/50/p1',
                id: 'summer-sale'
                title: 'Summer Sale'
                href: '#',
                  id: 'account'
                  title: 'Account'
                  href: '#',
                    id: 'logout'
                    title: 'Logout'
                    href: '#'
          ],
            id: 'search'
            title: 'Search'
  ]

  handleChange: (event) ->
    @props.setRouterState
      searchTxt: @refs.searchTxt.getDOMNode().value

  # Menu ul wrapper element.
  createNavEl: (children, name) ->
    ul
      className: name,
        children.map @createMenuEl

  # Menu li element.
  createMenuEl: (nav) ->
    section = @props.initState and @props.initState.section
    if nav.children and _.find(nav.children, id: section)
      itemIsActive = true
    else if section == nav.id
      itemIsActive = true
    else
      itemIsActive = false
    # Search has a special template.
    if nav.id == 'search'
      return @searchEl()
    # Item has sub-items.
    if nav.children and (@state[nav.id+'IsActive'] or itemIsActive)
      child = @createNavEl(nav.children, 'sub-menu')
    else
      child = false
    liClass = nav.id
    if itemIsActive
      liClass += ' active'
    # Template.
    li
      key: nav.id
      className: liClass,
        a
          href: nav.href,
            nav.title
        child

  # Decide what search code to render.
  searchEl: ->
    if (@props.initState and @props.initState.searchTxt) or @state.searchIsActive
      search = @searchElActive()
    else
      search = i
        onMouseOver: () => @setState searchIsActive: true
        className: 'fa fa-search',
          's'
    li
      key: 'search'
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
              ref: 'searchTxt'
              value: @props.initState.searchTxt
              onChange: @handleChange
              className: 'form-control'
              name: 'item-search'
              placeholder: 'Enter search text'


  render: () ->
    nav
      className: 'menu',
        @createNavEl @data, 'top-menu'
