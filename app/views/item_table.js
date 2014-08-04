(function() {
  var ItemColorRow, ItemPatternRow, React, table, tbody, th, thead, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), table = _ref.table, thead = _ref.thead, tbody = _ref.tbody, tr = _ref.tr, th = _ref.th;

  ItemPatternRow = require('./item_row_main');

  ItemColorRow = require('./item_row_sub');

  module.exports = React.createClass({
    render: function() {
      var lastName, lastPattern, rows, ths;
      rows = [];
      lastPattern = null;
      lastName = null;
      this.props.collection.forEach((function(_this) {
        return function(item) {
          var row_props;
          if (item.patternNumber !== lastPattern) {
            rows.push(ItemPatternRow({
              item: item,
              key: item.id,
              filter: _this.props.filter
            }));
          } else {
            row_props = {
              item: item,
              key: item.id,
              showName: lastName !== item.name,
              filter: _this.props.filter
            };
            rows.push(ItemColorRow(row_props));
          }
          lastPattern = item.patternNumber;
          return lastName = item.name;
        };
      })(this));
      ths = [];
      if (this.props.filter.category !== 'passementerie') {
        ths.push(th({
          className: 'c-name'
        }, 'Name'));
      }
      ths.push(th({
        className: 'c-number'
      }, 'Item#'));
      ths.push(th({
        className: 'c-color'
      }, 'Color'));
      ths.push(th({
        className: 'c-price'
      }, 'Net Price'));
      ths.push(th({
        className: 'c-content'
      }, 'Content'));
      if (this.props.filter.category !== 'leather') {
        ths.push(th({
          className: 'c-repeat'
        }, 'Repeat'));
      }
      if (this.props.filter.category === 'leather') {
        ths.push(th({
          className: 'c-size'
        }, 'Approx. Size'));
      } else {
        ths.push(th({
          className: 'c-size'
        }, 'Approx. Width'));
      }
      return table({}, thead({}, tr({}, ths)), tbody({}, rows));
    }
  });

}).call(this);
