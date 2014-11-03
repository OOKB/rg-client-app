AmpersandModel = require("ampersand-model")

module.exports = AmpersandModel.extend
  idAttribute: 'longUrl'
  url: ->
    baseUrl = 'https://api-ssl.bitly.com/v3/shorten/?access_token='
    baseUrl += 'f5206e2d7427db94b26c8706bb436415e821740c&longUrl='
    baseUrl + encodeURIComponent(@longUrl)

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
        'http://fav.rogersandgoffigon.com/'+@hash

  parse: (item) ->
    if item.data
      item = item.data
    item.shortUrl = item.url
    item.isNewHash = (item.new_hash)
    item.globalHash = item.global_hash
    item
