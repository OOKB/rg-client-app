(function() {
  var React, button, div, form, input, p, _ref;

  React = require('react');

  _ref = require('reactionary'), form = _ref.form, input = _ref.input, p = _ref.p, div = _ref.div, button = _ref.button;

  module.exports = React.createClass({
    handleChange: function() {
      return this.props.onUserInput(this.refs.filterTextInput.getDOMNode().value, this.refs.summerSale.getDOMNode().checked);
    },
    render: function() {
      return form({}, input({
        type: 'text',
        placeholder: 'Search...',
        value: this.props.filterText,
        ref: 'filterTextInput',
        onChange: this.handleChange
      }), div({}, button({
        value: 'textile'
      }, 'Textiles'), button({
        value: 'passementerie'
      }, 'Passementerie'), button({
        value: 'leather'
      }, 'Leather')), p({}, input({
        type: 'checkbox',
        value: this.props.summerSale,
        ref: 'summerSale',
        onChange: this.handleChange
      }), 'Only show summer sale products.'));
    }
  });

}).call(this);
