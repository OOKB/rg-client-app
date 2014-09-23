AmpersandModel = require("ampersand-model")
Lists = require './lists'
_ = require 'lodash'
r = require 'superagent'

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
    if _.isUndefined pj.order
      pj.order = _.random(0, 50)
    pj

  rmEntity: (entityId) ->
    @entities.remove entityId
    r.del 'http://r_g.cape.io/_index/list/' + @id + '/' + entityId+'?access_token='+app.me.token
      .end (res) ->
        console.log res

  url: ->
    'http://r_g.cape.io/_api/list/' + @id + '?access_token='+app.me.token
