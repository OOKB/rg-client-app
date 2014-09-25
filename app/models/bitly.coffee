AmpersandModel = require("ampersand-model")

module.exports = AmpersandModel.extend
  idAttribute: 'long_url'
  url: 'http://api.bitly.com/v3/shorten'
  props:
    longUrl: ['string', true]
    globalHash: 'string'
    hash: 'string'
    shortUrl: 'string'
    isNewHash: 'bool'

  derived:
    customUrl:
      deps: ['globalHash']
      fn: ->
        'http://fav.rogersandgoffigon.com/'+@globalHash

  parse: (item) ->
    if item.data
      item = item.data
    item.shortUrl = item.url
    item.isNewHash = (item.new_hash)
    item.globalHash = item.global_hash
    item

  ajaxConfig: (params) ->
    unless params
      params = {}
    params.url = 'http://api.bitly.com/v3/shorten'
    params.dataType = 'jsonp'
    params.data =
      "format": "json"
      "apiKey": "R_b83cfe54d0ecae82a9086a21fe834814"
      "login": "sundaysenergy"
      "longUrl": @longUrl
    console.log params
    return params
