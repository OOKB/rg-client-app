(function() {
  var ItemColorRow, ItemPatternRow, React, a, table, tbody, th, thead, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), table = _ref.table, thead = _ref.thead, tbody = _ref.tbody, tr = _ref.tr, th = _ref.th, a = _ref.a;

  ItemPatternRow = require('./item_row_main');

  ItemColorRow = require('./item_row_sub');

  module.exports = React.createClass({
    prefetchImg: function(e) {
      return console.log(e.target.id);
    },
    render: function() {
      var lastName, lastPattern, rows, ths;
      rows = [];
      lastPattern = null;
      lastName = null;
      this.props.collection.forEach((function(_this) {
        return function(item) {
          var colorValue, row_props;
          if (item._file) {
            colorValue = a({
              onMouseOver: _this.prefetchImg,
              id: item.id,
              href: item.detail
            }, item.color);
          } else {
            colorValue = item.color;
          }
          if (item.patternNumber !== lastPattern) {
            rows.push(ItemPatternRow({
              item: item,
              key: item.id,
              filter: _this.props.filter,
              colorValue: colorValue
            }));
          } else {
            row_props = {
              item: item,
              key: item.id,
              showName: lastName !== item.name,
              filter: _this.props.filter,
              colorValue: colorValue
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
          key: 'name',
          className: 'c-name'
        }, 'Name'));
      }
      ths.push(th({
        key: 'number',
        className: 'c-number'
      }, 'Item#'));
      ths.push(th({
        key: 'color',
        className: 'c-color'
      }, 'Color'));
      ths.push(th({
        key: 'price',
        className: 'c-price'
      }, 'Net Price'));
      ths.push(th({
        key: 'content',
        className: 'c-content'
      }, 'Content'));
      if (this.props.filter.category !== 'leather') {
        ths.push(th({
          key: 'repeat',
          className: 'c-repeat'
        }, 'Repeat'));
      }
      if (this.props.filter.category === 'leather') {
        ths.push(th({
          key: 'size',
          className: 'c-size'
        }, 'Approx. Size'));
      } else {
        ths.push(th({
          key: 'size',
          className: 'c-size'
        }, 'Approx. Width'));
      }
      return table({}, thead({}, tr({}, ths)), tbody({}, rows));
    }
  });

}).call(this);
