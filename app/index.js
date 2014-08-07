(function() {
  var ItemsCollection, React, Router, SubCollection, items_data;

  React = require('react');

  SubCollection = require('ampersand-subcollection');

  ItemsCollection = require('./models/items');

  Router = require('./router');

  items_data = require('./models/data');

  module.exports = {
    blastoff: function() {
      var el, items, self;
      self = window.app = this;
      items = new ItemsCollection(items_data, {
        parse: true
      });
      this.items = new SubCollection(items);
      this.router = new Router();
      el = document.getElementById('content');
      this.router.on('newPage', function(container) {
        this.container = container;
        return React.renderComponent(this.container, el);
      });
      return this.router.history.start();
    }
  };

  module.exports.blastoff();

}).call(this);
