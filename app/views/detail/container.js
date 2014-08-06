(function() {
  var HeaderBar, React, Switcher, button, div, h3, p, span, table, tbody, td, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, table = _ref.table, tbody = _ref.tbody, tr = _ref.tr, td = _ref.td, button = _ref.button, h3 = _ref.h3, p = _ref.p, span = _ref.span;

  HeaderBar = require('./header');

  Switcher = require('./buttons');

  module.exports = React.createClass({
    render: function() {
      var color_toggle_class, item;
      item = this.props.model;
      color_toggle_class = 'toggle-colors hidden-xs';
      if (item.far) {
        color_toggle_class += ' with-far';
      }
      return div({
        className: 'item-detail'
      }, HeaderBar({
        model: item
      }), Switcher({
        model: item
      }));
    }
  });

}).call(this);
