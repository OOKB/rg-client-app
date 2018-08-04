Collection = require('ampersand-rest-collection')
Project = require('./project')

baseUrl = 'https://r_g.cape.io/_api/'

module.exports = Collection.extend
  model: Project
  url: ->
    baseUrl+'list/_me?access_token='+app.me.token
  comparator: 'order'

  saveOrder: (ids) ->
    obj = entity: {}
    ids.forEach (id, i) =>
      list = @get(id)
      list.save order: i
    @sort()

    #url = baseUrl+'items/_index/'+app.me.customerNumber+'/list?access_token='+app.me.token
    return
