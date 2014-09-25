Collection = require('ampersand-rest-collection')
Model = require('./bitly')

module.exports = Collection.extend
  model: Model
  mainIndex: 'longUrl'
