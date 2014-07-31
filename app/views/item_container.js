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
        collection: 'textile'
      };
    },
    handleUserInput: function(filterText, collection) {
      return this.setState({
        filterText: filterText,
        collection: collection
      });
    },
    render: function() {
      return div({}, SearchBar({
        filterText: this.state.filterText,
        collection: this.state.collection,
        onUserInput: this.handleUserInput
      }), ProductTable({
        items: this.props.items,
        filterText: this.state.filterText,
        collection: this.state.collection
      }));
    }
  });

}).call(this);
