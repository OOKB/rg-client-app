(function() {
  var React, button, div, form, input, p, _, _ref;

  React = require('react');

  _ref = require('reactionary'), form = _ref.form, input = _ref.input, p = _ref.p, div = _ref.div, button = _ref.button;

  _ = require('lodash');

  module.exports = React.createClass({
    handleChange: function() {
      return this.props.onUserInput({
        filterText: this.refs.filterTextInput.getDOMNode().value,
        summerSale: this.refs.summerSale.getDOMNode().checked
      });
    },
    handleCollectionClick: function(collection_id, e) {
      if (e.preventDefault) {
        e.preventDefault();
      }
      return this.props.onUserInput({
        collection: collection_id
      });
    },
    render: function() {
      return form({}, input({
        type: 'text',
        placeholder: 'Search...',
        value: this.props.filterText,
        ref: 'filterTextInput',
        onChange: this.handleChange
      }), div({}, button({
        className: this.props.collection === 'textile' ? 'active' : void 0,
        onClick: _.partial(this.handleCollectionClick, 'textile'),
        value: 'textile'
      }, 'Textiles'), button({
        className: this.props.collection === 'passementerie' ? 'active' : void 0,
        onClick: _.partial(this.handleCollectionClick, 'passementerie'),
        value: 'passementerie'
      }, 'Passementerie'), button({
        className: this.props.collection === 'leather' ? 'active' : void 0,
        onClick: _.partial(this.handleCollectionClick, 'leather'),
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
