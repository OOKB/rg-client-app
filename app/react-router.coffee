React = require 'react'
{div, p} = require 'reactionary'
_ = require 'lodash'

Router = require './router'

Header = require './views/el/header'
Footer = require './views/el/footer'

FilterableProductTable = require './views/pricelist/item_container'
ItemDetail = require './views/detail/container'
Collection = require './views/collection/container'
Favs = require './views/favs'
Trade = require './views/trade/index'
Login = require './views/trade/login'
Account = require './views/trade/account'
Projects = require './views/trade/projects'

module.exports = React.createClass
  getInitialState: ->
    loggedIn: app.me.loggedIn

  router: new Router()

  componentDidMount: ->
    @router.setReactState = (newState) =>
      if newState
        @setState (newState)
    @router.history.start()
    app.me.on 'change:favs', (model, ids, change) =>
      if change and change.op == 'remove' and change.id and 'favs' == @state.section
        console.log 'Removing '+change.id
        s =
          ids: ids
          section: 'favs'
        newUrl = @router.urlCreate s
        #console.log newUrl
        console.log ids
        @router.navigate newUrl, replace: true
        @setRouterState ids: _.clone(ids)
    app.me.on 'change:loggedIn', (model, isLoggedIn) =>
      console.log 'change login', isLoggedIn
      s = {}
      if isLoggedIn and @state.section == 'login'
        @router.navigate('trade/account', replace: true)
        s.section = 'account'
      s.loggedIn = isLoggedIn
      @setState s

  setRouterState: (newState) ->
    if newState
      section = newState.section or @state.section
      searchableSection = _.contains ['pricelist', 'collection', 'summer'], section
      if newState.searchTxt and not searchableSection
        searchableSection = true
        newState.section = 'collection'
        console.log 'Going to search pg.'
      if searchableSection
        #console.log @state
        s = @router.prepNewState _.defaults(newState, @state)
        #redirected = @router.updateURL @state, s
        # Handle in-app state change options.
        if s.searchTxt
          if s.searchTxt != @state.searchTxt
            # Reset pageIndex.
            s.pageIndex = 1
      # else if 'detail' == newState.section
      #   s = newState
      else if 'favs' == section or 'projects' == section
        s = @router.prepNewState _.defaults(newState, @state)
      else
        s = newState
      console.log s
      @setState s

  componentDidUpdate: (prevProps, prevState) ->
    @router.updateURL prevState, @state
    return

  render: ->
    section = null
    if @state and @state.section
      section = @state.section
    props =
      collection: app.items
      initState: @state
      setRouterState: @setRouterState

    if _.isObject props.initState
      props.initState.setRouterState = @setRouterState

    headerEl = Header props
    component = switch section
      when 'pricelist' then FilterableProductTable(props)
      when 'collection', 'summer' then Collection(props)
      when 'detail' then ItemDetail(props)
      when 'favs' then Favs(props)
      when 'login' then Login(props)
      when 'trade' then Trade(props)
      when 'account' then Account(props)
      when 'projects' then Projects(props)
      else p 'Hello there! Unfortunately our application is broken... ' + section
    footer = Footer props

    return div headerEl, component, footer
