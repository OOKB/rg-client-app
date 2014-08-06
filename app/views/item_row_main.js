(function() {
  var React, th, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), tr = _ref.tr, th = _ref.th;

  module.exports = React.createClass({
    render: function() {
      var item, td, tds;
      td = th;
      tds = [];
      item = this.props.item;
      if (this.props.filter.category !== 'passementerie') {
        tds.push(td({
          className: 'c-name'
        }, item.name));
      }
      tds.push(td({
        className: 'c-number'
      }, item.id));
      tds.push(td({
        className: 'c-color'
      }, item.color));
      tds.push(td({
        className: 'c-price'
      }, item.price));
      tds.push(td({
        className: 'c-content'
      }, item.contents));
      if (this.props.filter.category !== 'leather') {
        tds.push(td({
          className: 'c-repeat'
        }, item.repeat));
      }
      tds.push(td({
        className: 'c-size'
      }, item.approx_width));
      return tr({
        className: 'pattern'
      }, tds);
    }
  });

}).call(this);
