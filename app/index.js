(function() {
  var FilterableProductTable, React, div, el, h1, items, li, p, table, tbody, th, thead, tr, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, h1 = _ref.h1, p = _ref.p, ul = _ref.ul, li = _ref.li, table = _ref.table, thead = _ref.thead, tr = _ref.tr, th = _ref.th, tbody = _ref.tbody;

  FilterableProductTable = require('./views/item_container');

  items = [
    {
      name: 'Bechamel',
      patternNumber: '938001',
      color_id: '20',
      color: 'Mantis',
      price: '109',
      size: '54"',
      collection: 'textile'
    }, {
      name: 'Bechamel',
      patternNumber: '938001',
      color_id: '23',
      color: 'Adams',
      price: '109',
      size: '54"',
      collection: 'textile'
    }, {
      name: 'Benderlock',
      patternNumber: '890001',
      color_id: '01',
      color: 'Brucefield',
      price: '92',
      size: '58"',
      collection: 'textile'
    }, {
      name: 'Benderlock',
      patternNumber: '890001',
      color_id: '02',
      color: 'Buckpool',
      price: '92',
      size: '58"',
      collection: 'textile'
    }
  ];

  el = div({}, h1('hello whale'), ul({}, li('one'), li('two')));

  React.renderComponent(FilterableProductTable({
    items: items
  }), document.getElementById('content'));

}).call(this);
