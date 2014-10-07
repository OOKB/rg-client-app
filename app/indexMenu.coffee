React = require 'react'
Me = require './models/me'
Bitly = require './models/bitly_collection'
TradeMenu = require './views/el/menu_trade'

module.exports =
  blastoff: ->
    self = window.app = @
    @bitly = new Bitly()
    @me = new Me()
    # The trade menu element.
    el = document.getElementById('trade-menu')
    React.renderComponent TradeMenu(), el

module.exports.blastoff()
