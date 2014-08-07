(function() {
  var React, button, div, h3, p, span, table, tbody, td, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, table = _ref.table, tbody = _ref.tbody, tr = _ref.tr, td = _ref.td, button = _ref.button, h3 = _ref.h3, p = _ref.p, span = _ref.span;

  module.exports = React.createClass({
    render: function() {
      var item;
      item = this.props.model;
      return table({
        className: 'itemoverlay-header'
      }, tbody({}, tr({}, td({
        className: 'fav',
        width: '29'
      }, button({
        className: 'fav'
      }, '+')), td({
        className: 'name'
      }, h3({}, item.label || item.category), p({}, span({
        className: 'roman'
      }, item.name), item.id)), td({
        className: 'color'
      }, h3('Color'), p(item.color)), td({
        className: 'content'
      }, h3('Content'), p(item.contents)), td({
        className: 'repeat'
      }, h3('Repeat'), p(item.repeat)), td({
        className: 'width'
      }, h3('Approx Width'), p(item.approx_width)), td({
        className: 'close'
      }, button({
        className: 'close',
        type: 'button',
        'area-hidden': 'true'
      }, 'X')))));
    }
  });

}).call(this);
