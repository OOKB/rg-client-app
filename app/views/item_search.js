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
    pageNext: function(e) {
      if (this.props.filter.pageIndex !== this.props.total_pages - 1) {
        return this.props.onUserInput({
          pageIndex: this.props.filter.pageIndex + 1
        });
      }
    },
    pagePrevious: function(e) {
      if (this.props.filter.pageIndex !== 0) {
        return this.props.onUserInput({
          pageIndex: this.props.filter.pageIndex - 1
        });
      }
    },
    render: function() {
      var current_page, pager_next_class, pager_previous_class, total_pages, v;
      v = this.props.filter;
      total_pages = this.props.total_pages;
      pager_previous_class = 'previous';
      if (v.pageIndex === 0) {
        pager_previous_class += ' disabled';
      }
      pager_next_class = 'next';
      current_page = v.pageIndex + 1;
      if (current_page === total_pages) {
        pager_next_class += ' disabled';
      }
      return form({}, input({
        type: 'text',
        placeholder: 'Search...',
        value: v.searchTxt,
        ref: 'filterTextInput',
        onChange: this.handleChange
      }), div({}, button({
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
      }, 'Leather')), div({
        className: 'pricelist-header'
      }, ul({
        className: 'pager'
      }, li({
        className: pager_previous_class
      }, a({
        className: 'left',
        role: 'button',
        ref: 'pager-previous',
        onClick: this.pagePrevious
      }, '&#60;')), li({
        className: 'pageselect'
      }, select({
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
      }, 'All'))), li({
        className: 'pagecount'
      }, current_page + ' / ' + total_pages), li({
        className: 'next'
      }, a({
        className: 'right',
        role: 'button',
        ref: 'pager-next',
        onClick: this.pageNext
      }, '&#62;')))));
    }
  });

}).call(this);
