(function() {
  var ItemColorRow, ItemPatternRow, React, a, table, tbody, th, thead, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), table = _ref.table, thead = _ref.thead, tbody = _ref.tbody, tr = _ref.tr, th = _ref.th, a = _ref.a;

  ItemPatternRow = require('./item_row_main');

  ItemColorRow = require('./item_row_sub');

  module.exports = React.createClass({
    prefetchImg: function(e) {
      var id, img, item;
      id = e.target.id;
      item = this.props.collection.get(id);
      if (item._file && item._file.large && item._file.large.path) {
        img = new Image();
        img.src = item._file.large.path;
        return console.log('Preload ' + img.src);
      }
    },
    render: function() {
      var lastName, lastPattern, rows, ths;
      rows = [];
      lastPattern = null;
      lastName = null;
      this.props.collection.forEach((function(_this) {
        return function(item) {
          var a_ops, colorIdValue, colorValue, idValue, row_props;
          if (item._file && item.category !== 'passementerie') {
            a_ops = {
              onMouseDown: _this.prefetchImg,
              id: item.id,
              href: item.detail
            };
            colorValue = a(a_ops, item.color);
            idValue = a(a_ops, item.id);
            colorIdValue = a(a_ops, item.color_id);
          } else {
            colorValue = item.color;
            idValue = item.id;
            colorIdValue = item.color_id;
          }
          if (item.patternNumber !== lastPattern) {
            rows.push(ItemPatternRow({
              item: item,
              key: item.id,
              filter: _this.props.filter,
              colorValue: colorValue,
              idValue: idValue
            }));
          } else {
            row_props = {
              item: item,
              key: item.id,
              showName: lastName !== item.name,
              filter: _this.props.filter,
              colorValue: colorValue,
              idValue: colorIdValue
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
