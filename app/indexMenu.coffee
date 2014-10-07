React = window.react
Me = require './models/me'
TradeMenu = require './views/el/menu_trade'

module.exports =
  blastoff: ->
    self = window.app = @
    Cookies.get('token')
    # The trade menu element.
    el = document.getElementById('trade-menu')
    React.renderComponent TradeMenu, el

module.exports.blastoff()
