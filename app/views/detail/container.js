(function() {
  var HeaderBar, React, Switcher, button, div, h3, p, span, table, tbody, td, tr, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, table = _ref.table, tbody = _ref.tbody, tr = _ref.tr, td = _ref.td, button = _ref.button, h3 = _ref.h3, p = _ref.p, span = _ref.span;

  HeaderBar = require('./header');

  Switcher = require('./buttons');

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        color_id: this.props.initColor,
        patternNumber: this.props.patternNumber,
        pageIndex: 0
      };
    },
    handleUserInput: function(newSt) {
      return this.setState(newSt);
    },
    render: function() {
      var color_toggle_class, item, props;
      item = this.props.collection.get(this.state.patternNumber + '-' + this.state.color_id);
      color_toggle_class = 'toggle-colors hidden-xs';
      if (item.far) {
        color_toggle_class += ' with-far';
      }
      props = {
        model: item,
        collection: this.props.collection,
        pageIndex: this.state.pageIndex,
        onUserInput: this.handleUserInput
      };
      return div({
        className: 'item-detail ' + item.category
      }, HeaderBar(props), Switcher(props));
    }
  });

}).call(this);
