(function() {
  var React, form, input, p, _ref;

  React = require('react');

  _ref = require('reactionary'), form = _ref.form, input = _ref.input, p = _ref.p;

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
      }), p({}, input({
        type: 'checkbox',
        value: this.props.summerSale,
        ref: 'summerSale',
        onChange: this.handleChange
      }), 'Only show summer sale products.'));
    }
  });

}).call(this);
