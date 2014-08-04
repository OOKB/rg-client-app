(function() {
  var ItemTable, React, SearchBar, div;

  React = require('react');

  div = require('reactionary').div;

  SearchBar = require('./item_search');

  ItemTable = require('./item_table');

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        searchTxt: '',
        category: 'textile',
        summerSale: false,
        pageSize: 50,
        pageIndex: 0,
        patternNumber: null,
        color_id: null,
        display: 'pricelist'
      };
    },
    handleUserInput: function(new_state_obj) {
      if (new_state_obj.searchTxt && new_state_obj.searchTxt.length > 1) {
        new_state_obj.searchTxt = new_state_obj.searchTxt.toLowerCase();
      }
      return this.setState(new_state_obj);
    },
    render: function() {
      return div({}, SearchBar({
        onUserInput: this.handleUserInput,
        filter: this.state
      }), ItemTable({
        collection: this.props.collection,
        filter: this.state
      }));
    }
  });

}).call(this);
