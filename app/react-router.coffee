React = require 'react'
Router = require './router'
{div, p} = require 'reactionary'

FilterableProductTable = require './views/pricelist/item_container'
ItemDetail = require './views/detail/container'
Collection = require './views/collection/container'

module.exports = React.createClass

  componentDidMount: ->
    app.router = new Router()
    app.router.setReactState = (newState) =>
      if newState
        @setState (newState)

    app.router.history.start()

  setRouterState: (newState) ->
    if newState
      @setState newState

  render: ->
    section = null
    if @state and @state.section
      section = @state.section
    props =
      collection: app.items
      initState: @state

    component = switch section
      when 'pricelist' then FilterableProductTable(props)
      when 'collection' then Collection(props)
      when 'detail' then ItemDetail(props)
      else p 'hello'
    return component
