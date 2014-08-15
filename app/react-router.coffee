React = require 'react'
{div, p} = require 'reactionary'
_ = require 'underscore'

Router = require './router'

FilterableProductTable = require './views/pricelist/item_container'
ItemDetail = require './views/detail/container'
Collection = require './views/collection/container'

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
      redirected = @router.updateURL @state, s
      if redirected
        @router.itemsFilter app.items, s
      #console.log s
      @setState s

  render: ->
    section = null
    if @state and @state.section
      section = @state.section
    props =
      collection: app.items
      initState: @state
      setRouterState: @setRouterState

    component = switch section
      when 'pricelist' then FilterableProductTable(props)
      when 'collection' then Collection(props)
      when 'detail' then ItemDetail(props)
      else p 'hello'
    return component
