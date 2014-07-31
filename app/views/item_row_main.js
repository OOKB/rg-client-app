(function() {
  var React, th, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), tr = _ref.tr, th = _ref.th;

  module.exports = React.createClass({
    render: function() {
      return tr({
        className: 'pattern'
      }, th(this.props.item.name), th(this.props.item.patternNumber + '-' + this.props.item.color_id), th(this.props.item.color), th(this.props.item.price), th(this.props.item.approx_width));
    }
  });

}).call(this);
