React = require 'react'
{div, p} = require 'reactionary'
_ = require 'lodash'

Router = require './router'

FilterableProductTable = require './views/pricelist/item_container'
ItemDetail = require './views/detail/container'
Collection = require './views/collection/container'
Favs = require './views/favs'

module.exports = React.createClass

  router: new Router()

  componentDidMount: ->
    @router.setReactState = (newState) =>
      if newState
        @setState (newState)
    @router.history.start()
    app.me.on 'change:favs', (model, ids, change) =>
      if change and change.op == 'remove' and change.id
        console.log 'Removing '+change.id
        s =
          ids: ids
          section: 'favs'
        newUrl = @router.urlCreate s
        #console.log newUrl
        console.log ids
        @router.navigate newUrl, replace: true
        @setRouterState ids: _.clone(ids)

  setRouterState: (newState) ->
    if newState
      section = newState.section or @state.section
      if 'pricelist' == section or 'collection' == section
        #console.log @state
        s = @router.prepNewState _.defaults(newState, @state)
        redirected = @router.updateURL @state, s
        # Handle in-app state change options.
        if s.searchTxt
          if s.searchTxt != @state.searchTxt
            # Reset pageIndex.
            s.pageIndex = 1
      # else if 'detail' == newState.section
      #   s = newState
      else if 'favs' == section
        s = @router.prepNewState _.defaults(newState, @state)
      else
        s = newState
      @setState s

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
    component = switch section
      when 'pricelist' then FilterableProductTable(props)
      when 'collection' then Collection(props)
      when 'detail' then ItemDetail(props)
      when 'favs' then Favs(props)
      else p 'Hello there! Unfortunately our application is broken... ' + section
    return component
