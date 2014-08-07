(function() {
  var FilterableProductTable, ItemDetail, Router;

  Router = require('ampersand-router');

  FilterableProductTable = require('./views/pricelist/item_container');

  ItemDetail = require('./views/detail/container');

  module.exports = Router.extend({
    routes: {
      '': 'pricelist',
      'pricelist': 'pricelist',
      'detail/:pattern/:id': 'itemView'
    },
    pricelist: function() {
      var props;
      props = {
        collection: app.items
      };
      return this.trigger('newPage', FilterableProductTable(props));
    },
    itemView: function(patternNumber, color_id) {
      var config, props;
      config = {
        where: {
          patternNumber: patternNumber
        }
      };
      app.items.configure(config, true);
      props = {
        initColor: color_id,
        collection: app.items,
        patternNumber: patternNumber
      };
      return this.trigger('newPage', ItemDetail(props));
    }
  });

}).call(this);
