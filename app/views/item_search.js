(function() {
  var React, a, button, div, form, input, li, option, p, select, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), form = _ref.form, input = _ref.input, p = _ref.p, div = _ref.div, button = _ref.button, select = _ref.select, option = _ref.option, ul = _ref.ul, li = _ref.li, a = _ref.a;

  module.exports = React.createClass({
    handleChange: function(event) {
      return this.props.onUserInput({
        searchTxt: this.refs.filterTextInput.getDOMNode().value,
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
        category: collection_id
      });
    },
    render: function() {
      var v;
      v = this.props.filter;
      return div({}, form({}, input({
        type: 'text',
        placeholder: 'Search...',
        value: v.searchTxt,
        ref: 'filterTextInput',
        onChange: this.handleChange
      }), select({
        ref: 'setPageSize',
        value: v.pageSize,
        onChange: this.handleChange,
        type: 'select'
      }, option({
        value: '50'
      }, '50'), option({
        value: '100'
      }, '100'), option({
        value: '10000'
      }, 'All')), div({}, button({
        className: v.category === 'textile' ? 'active' : void 0,
        onClick: this.handleCollectionClick,
        value: 'textile'
      }, 'Textiles'), button({
        className: v.category === 'passementerie' ? 'active' : void 0,
        onClick: this.handleCollectionClick,
        value: 'passementerie'
      }, 'Passementerie'), button({
        className: v.category === 'leather' ? 'active' : void 0,
        onClick: this.handleCollectionClick,
        value: 'leather'
      }, 'Leather')), p({}, input({
        type: 'checkbox',
        value: v.summerSale,
        ref: 'summerSale',
        onChange: this.handleChange
      }), 'Only show summer sale products.')), div({
        className: 'pricelist-header'
      }, ul({
        className: 'pager'
      }, li({
        className: 'previous disabled'
      }, a({
        className: 'left',
        role: 'button',
        ref: 'pager-previous'
      }, '&#60;')), li({
        className: 'pageselect'
      }, 'dropdown'), li({
        className: 'pagecount'
      }, '1/ 10101010'), li({
        className: 'next'
      }, a({
        className: 'right',
        role: 'button',
        ref: 'pager-next'
      }, '&#62;')))));
    }
  });

}).call(this);
