(function() {
  var React, a, th, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), tr = _ref.tr, th = _ref.th, a = _ref.a;

  module.exports = React.createClass({
    propTypes: {
      item: React.PropTypes.object.isRequired,
      filter: React.PropTypes.object.isRequired,
      colorValue: React.PropTypes.any.isRequired
    },
    render: function() {
      var item, td, tds;
      td = th;
      tds = [];
      item = this.props.item;
      if (this.props.filter.category !== 'passementerie') {
        tds.push(td({
          key: 'name',
          className: 'c-name'
        }, item.name));
      }
      tds.push(td({
        key: 'number',
        className: 'c-number'
      }, item.id));
      tds.push(td({
        key: 'color',
        className: 'c-color'
      }, this.props.colorValue));
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
