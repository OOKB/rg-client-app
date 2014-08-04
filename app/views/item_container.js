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
        new_state_obj.pageIndex = this.getInitialState().pageIndex;
      }
      this.filterCollection(new_state_obj);
      return this.setState(new_state_obj);
    },
    filterCollection: function(new_state) {
      var config, pageIndex, pageSize, reset_collection;
      reset_collection = false;
      if (new_state) {
        if (new_state.category && new_state.category !== this.state.category) {
          reset_collection = true;
        }
      } else {
        new_state = this.state;
      }
      pageSize = new_state.pageSize || this.state.pageSize;
      pageIndex = new_state.pageIndex || this.state.pageIndex;
      config = {};
      if (new_state.category) {
        config.where = {
          category: new_state.category
        };
      }
      if (new_state.pageSize || reset_collection) {
        config.limit = pageSize;
      }
      if (new_state.pageIndex || reset_collection) {
        config.offset = pageIndex * pageSize;
      }
      return this.props.collection.configure(config, reset_collection);
    },
    render: function() {
      if (!this.isMounted()) {
        this.filterCollection();
        console.log('not mounted');
      }
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
