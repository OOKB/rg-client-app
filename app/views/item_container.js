(function() {
  var ProductTable, React, SearchBar, div;

  React = require('react');

  div = require('reactionary').div;

  SearchBar = require('./item_search');

  ProductTable = require('./item_table');

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        filterText: '',
        collection: 'textile',
        summerSale: false,
        pageSize: 50,
        pageIndex: 0
      };
    },
    handleUserInput: function(new_state_obj) {
      return this.setState(new_state_obj);
    },
    render: function() {
      return div({}, SearchBar({
        onUserInput: this.handleUserInput,
        filterText: this.state.filterText,
        collection: this.state.collection,
        summerSale: this.state.summerSale,
        pageSize: this.state.pageSize,
        pageIndex: this.state.pageIndex
      }), ProductTable({
        items: this.props.items,
        filterText: this.state.filterText,
        collection: this.state.collection,
        summerSale: this.state.summerSale,
        pageSize: this.state.pageSize,
        pageIndex: this.state.pageIndex
      }));
    }
  });

}).call(this);
