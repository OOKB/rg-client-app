AmpersandModel = require("ampersand-model")
Lists = require './lists'
_ = require 'lodash'

module.exports = AmpersandModel.extend
  props:
    id: ['string']
    name: ['string', true]
    order: 'number'
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

  parse: (pj, i) ->
    unless pj.order
      pj.order = _.random(0, 50)
    pj

  url: ->
    'http://r_g.cape.io/_api/list/' + @id + '?access_token='+app.me.token
