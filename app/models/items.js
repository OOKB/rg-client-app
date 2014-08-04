(function() {
  var Collection, Item;

  Collection = require('ampersand-collection');

  Item = require('./item');

  module.exports = Collection.extend({
    model: Item
  });

}).call(this);
