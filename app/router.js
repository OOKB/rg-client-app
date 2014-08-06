(function() {
  var FilterableProductTable, ItemDetail, Router;

  Router = require('ampersand-router');

  FilterableProductTable = require('./views/pricelist/item_container');

  ItemDetail = require('./views/detail/container');

  module.exports = Router.extend({
    routes: {
      '': 'pricelist',
      'pricelist': 'pricelist',
      'detail/:id': 'itemView'
    },
    pricelist: function() {
      var props;
      props = {
        collection: app.items
      };
      return this.trigger('newPage', FilterableProductTable(props));
    },
    itemView: function(id) {
      var props;
      props = {
        model: app.items.get(id)
      };
      return this.trigger('newPage', ItemDetail(props));
    }
  });

}).call(this);
