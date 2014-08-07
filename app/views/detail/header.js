(function() {
  var React, button, div, h3, li, p, span, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, button = _ref.button, h3 = _ref.h3, p = _ref.p, span = _ref.span, ul = _ref.ul, li = _ref.li;

  module.exports = React.createClass({
    handleXclick: function() {
      return window.history.back();
    },
    render: function() {
      var item;
      item = this.props.model;
      return ul({
        className: 'itemoverlay-header'
      }, li({
        className: 'fav',
        width: '29'
      }, button({
        className: 'fav'
      }, '+')), li({
        className: 'name'
      }, h3({}, item.label || item.category), p({}, span({
        className: 'roman'
      }, item.name), item.id)), li({
        className: 'color'
      }, h3('Color'), p(item.color)), li({
        className: 'content'
      }, h3('Content'), p(item.contents)), li({
        className: 'repeat'
      }, h3('Repeat'), p(item.repeat)), li({
        className: 'width'
      }, h3('Approx Width'), p(item.approx_width)), li({
        className: 'close'
      }, button({
        className: 'close',
        type: 'button',
        onClick: this.handleXclick,
        'area-hidden': 'true'
      }, 'X')));
    }
  });

}).call(this);
