(function() {
  var React, button, div, form, input, option, p, select, _ref;

  React = require('react');

  _ref = require('reactionary'), form = _ref.form, input = _ref.input, p = _ref.p, div = _ref.div, button = _ref.button, select = _ref.select, option = _ref.option;

  module.exports = React.createClass({
    handleChange: function(event) {
      return this.props.onUserInput({
        filterText: this.refs.filterTextInput.getDOMNode().value,
        summerSale: this.refs.summerSale.getDOMNode().checked,
        pageSize: this.refs.setPageSize.getDOMNode().value
      });
    },
    handleCollectionClick: function(e) {
      var collection_id;
      collection_id = e.target.value;
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
      }), select({
        ref: 'setPageSize',
        value: this.props.pageSize,
        onChange: this.handleChange,
        type: 'select'
      }, option({
        value: '50'
      }, '50'), option({
        value: '100'
      }, '100'), option({
        value: '10000'
      }, 'All')), div({}, button({
        className: this.props.collection === 'textile' ? 'active' : void 0,
        onClick: this.handleCollectionClick,
        value: 'textile'
      }, 'Textiles'), button({
        className: this.props.collection === 'passementerie' ? 'active' : void 0,
        onClick: this.handleCollectionClick,
        value: 'passementerie'
      }, 'Passementerie'), button({
        className: this.props.collection === 'leather' ? 'active' : void 0,
        onClick: this.handleCollectionClick,
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
