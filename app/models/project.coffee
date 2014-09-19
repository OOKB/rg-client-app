AmpersandModel = require("ampersand-model")
Lists = require './lists'
module.exports = AmpersandModel.extend
  props:
    id: ['string', true]
    name: ['string', true]
    uid:
      type: 'string'
      required: true
      default: ->
        if app and app.me and app.me.customerNumber
          app.me.customerNumber
        else
          null

  children:
    entities: Lists
