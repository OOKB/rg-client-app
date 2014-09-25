Collection = require('ampersand-rest-collection')
Model = require('./bitly')

module.exports = Collection.extend
  model: Model
  #url: 'http://api.bitly.com/v3/shorten'
