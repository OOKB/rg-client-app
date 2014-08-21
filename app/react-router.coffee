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

  setRouterState: (newState) ->
    if newState
      s = _.defaults newState, @state
      if 'pricelist' == s.section or 'collection' == s.section
        #console.log @state
        s = @router.prepNewState s
        redirected = @router.updateURL @state, s
        # Handle in-app state change options.
        if s.searchTxt
          if s.searchTxt != @state.searchTxt
            # Reset pageIndex.
            s.pageIndex = 1
      else if 'detail' == newState.section
        s = newState
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
      when 'favs' then Favs props
      else p 'Hello there! Unfortunately our application is broken... ' + section
    return component
