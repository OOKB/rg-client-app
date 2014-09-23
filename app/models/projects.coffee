Collection = require('ampersand-rest-collection')
Project = require('./project')

module.exports = Collection.extend
  model: Project
  url: ->
    'http://r_g.cape.io/_api/list/_me?access_token='+app.me.token
  comparator: 'order'
