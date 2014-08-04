(function() {
  var FilterableProductTable, ItemsCollection, React, SubCollection, items_data;

  React = require('react');

  SubCollection = require('ampersand-subcollection');

  ItemsCollection = require('./models/items');

  FilterableProductTable = require('./views/item_container');

  items_data = require('./models/data.json');

  module.exports = {
    blastoff: function() {
      var el, items, props, self;
      self = window.app = this;
      items = new ItemsCollection(items_data);
      this.items = new SubCollection(items);
      props = {
        collection: this.items
      };
      this.container = FilterableProductTable(props);
      el = document.getElementById('content');
      return React.renderComponent(this.container, el);
    }
  };

  module.exports.blastoff();

}).call(this);
