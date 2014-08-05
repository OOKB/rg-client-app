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
      if (new_state_obj.searchTxt && new_state_obj.searchTxt !== this.state.searchTxt) {
        if (new_state_obj.searchTxt.length > 1) {
          new_state_obj.searchTxt = new_state_obj.searchTxt.toLowerCase();
        }
        new_state_obj.pageIndex = this.getInitialState().pageIndex;
      }
      if (new_state_obj.category && new_state_obj.category !== this.state.category) {
        new_state_obj.pageIndex = this.getInitialState().pageIndex;
      }
      if (new_state_obj.pageSize) {
        new_state_obj.pageSize = parseInt(new_state_obj.pageSize);
      }
      if (new_state_obj.pageIndex) {
        new_state_obj.pageIndex = parseInt(new_state_obj.pageIndex);
      }
      this.filterCollection(new_state_obj);
      return this.setState(new_state_obj);
    },
    filterCollection: function(new_state) {
      var config, pageIndex, pageSize, reset_collection, text_to_search_for;
      reset_collection = true;
      if (!new_state) {
        new_state = this.state;
      }
      config = {};
      config.where = {
        category: new_state.category || this.state.category
      };
      if (new_state.searchTxt !== '') {
        text_to_search_for = new_state.searchTxt || this.state.searchTxt;
      } else {
        text_to_search_for = false;
      }
      if (text_to_search_for) {
        config.filter = function(model) {
          return model.searchStr.indexOf(text_to_search_for) > -1;
        };
      }
      pageSize = new_state.pageSize || this.state.pageSize;
      if (new_state.pageIndex !== 0) {
        pageIndex = new_state.pageIndex || this.state.pageIndex;
      } else {
        pageIndex = 0;
      }
      config.limit = pageSize;
      config.offset = pageIndex * pageSize;
      return this.props.collection.configure(config, reset_collection);
    },
    render: function() {
      if (!this.isMounted()) {
        this.filterCollection();
        console.log('not mounted');
      }
      return div({}, SearchBar({
        onUserInput: this.handleUserInput,
        filter: this.state,
        total_pages: Math.ceil(this.props.collection.filtered_length / this.state.pageSize)
      }), ItemTable({
        collection: this.props.collection,
        filter: this.state
      }));
    }
  });

}).call(this);
