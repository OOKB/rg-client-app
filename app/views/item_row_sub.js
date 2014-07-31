(function() {
  var React, td, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), tr = _ref.tr, td = _ref.td;

  module.exports = React.createClass({
    render: function() {
      return tr({
        className: 'pattern'
      }, td(''), td(this.props.item.color_id), td(this.props.item.color), td(''), td(''));
    }
  });

}).call(this);
