(function() {
  var React, button, div, p, span, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, button = _ref.button, span = _ref.span, p = _ref.p;

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        color_box_view: false,
        color_box_pg: 0,
        far_view: false,
        id: '01'
      };
    },
    render: function() {
      var color_toggle_class, divs, item;
      item = this.props.model;
      divs = [];
      color_toggle_class = 'toggle-colors hidden-xs';
      if (item.far) {
        color_toggle_class += ' with-far';
      }
      divs.push(div({
        key: 'color-button',
        className: color_toggle_class
      }, button({
        className: 'uppercase'
      }, 'Colors')));
      if (item.far) {
        divs.push(div({
          key: 'far-button',
          className: 'toggle-far hidden-xs'
        }, button({
          className: 'uppercase'
        }, span({
          className: 'pattern'
        }, 'View Pattern'))));
      }
      return div({
        className: 'switcher'
      }, divs);
    }
  });

}).call(this);
