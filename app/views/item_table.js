(function() {
  var ItemColorRow, ItemPatternRow, React, table, tbody, th, thead, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), table = _ref.table, thead = _ref.thead, tbody = _ref.tbody, tr = _ref.tr, th = _ref.th;

  ItemPatternRow = require('./item_row_main');

  ItemColorRow = require('./item_row_sub');

  module.exports = React.createClass({
    render: function() {
      var lastPattern, rows;
      rows = [];
      lastPattern = null;
      this.props.items.forEach((function(_this) {
        return function(item) {
          var id, search_not_found, search_string;
          id = item.patternNumber + item.color_id;
          search_string = (id + item.name + item.color).toLowerCase();
          search_not_found = search_string.indexOf(_this.props.filterText.toLowerCase()) === -1;
          if (search_not_found) {
            return;
          }
          if (item.patternNumber !== lastPattern) {
            rows.push(ItemPatternRow({
              item: item,
              key: id
            }));
          } else {
            rows.push(ItemColorRow({
              item: item,
              key: id
            }));
          }
          return lastPattern = item.patternNumber;
        };
      })(this));
      return table({}, thead({}, tr({}, th('Name'), th('Number'), th('Color'), th('Net Price'), th('Size'))), tbody({}, rows));
    }
  });

}).call(this);
