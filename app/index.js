(function() {
  var FilterableProductTable, React, div, h1, items, li, p, table, tbody, th, thead, tr, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, h1 = _ref.h1, p = _ref.p, ul = _ref.ul, li = _ref.li, table = _ref.table, thead = _ref.thead, tr = _ref.tr, th = _ref.th, tbody = _ref.tbody;

  FilterableProductTable = require('./views/item_container');

  items = require('./data.json');

  React.renderComponent(FilterableProductTable({
    items: items
  }), document.getElementById('content'));

}).call(this);
