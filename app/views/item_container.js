(function() {
  var ItemTable, React, SearchBar, div, queryParam;

  React = require('react');

  div = require('reactionary').div;

  queryParam = require('query-param-getter');

  SearchBar = require('./item_search');

  ItemTable = require('./item_table');

  module.exports = React.createClass({
    getInitialState: function() {
      var q;
      q = this.getQuery();
      return {
        searchTxt: q.searchTxt,
        category: q.category,
        summerSale: false,
        pageSize: 50,
        pageIndex: q.pageIndex,
        patternNumber: null,
        color_id: null,
        display: 'pricelist',
        printing: false
      };
    },
    getQuery: function() {
      var q;
      q = {};
      q.category = (function() {
        switch (queryParam('c')) {
          case 't':
            return 'textile';
          case 'textile':
            return 'textile';
          case 'p':
            return 'passementerie';
          case 'passementerie':
            return 'passementerie';
          case 'l':
            return 'leather';
          case 'leather':
            return 'leather';
          default:
            return 'textile';
        }
      })();
      q.searchTxt = queryParam('q') || '';
      if (q.searchTxt !== '') {
        q.searchTxt = this.searchTxt(q.searchTxt);
      }
      q.pageIndex = parseInt(queryParam('pg')) || 0;
      return q;
    },
    setQuery: function(new_state) {
      var new_q, pathname, q;
      q = this.getQuery();
      if (new_state.category) {
        q.category = new_state.category;
      }
      pathname = location.pathname;
      new_q = '?c=' + q.category;
      if (new_state.searchTxt) {
        new_q += '&q=' + new_state.searchTxt;
      }
      if (typeof new_state.pageIndex === 'number') {
        new_q += '&pg=' + new_state.pageIndex;
      }
      return window.history.replaceState({}, '', pathname + new_q);
    },
    searchTxt: function(search_string) {
      if (typeof search_string === 'undefined') {
        return this.state.searchTxt || '';
      } else if (this.state && this.state.searchTxt && search_string === this.state.searchTxt) {
        return search_string;
      } else {
        search_string = search_string.toLowerCase();
        search_string = search_string.replace(/[^a-z0-9-]/, '');
        return search_string;
      }
    },
    handleUserInput: function(new_state_obj) {
      var search_string;
      if (!new_state_obj.printing) {
        new_state_obj.printing = false;
      }
      if (search_string = this.searchTxt(new_state_obj.searchTxt)) {
        new_state_obj.searchTxt = search_string;
        if (search_string !== this.state.searchTxt) {
          new_state_obj.pageIndex = 0;
        }
      }
      if (new_state_obj.category && new_state_obj.category !== this.state.category) {
        new_state_obj.pageIndex = 0;
      }
      if (new_state_obj.pageSize) {
        new_state_obj.pageSize = parseInt(new_state_obj.pageSize);
        if (new_state_obj.pageSize !== this.state.pageSize) {
          new_state_obj.pageIndex = 0;
        }
      }
      if (new_state_obj.pageIndex) {
        new_state_obj.pageIndex = parseInt(new_state_obj.pageIndex);
      }
      if (new_state_obj.printing) {
        new_state_obj.pageIndex = 0;
        new_state_obj.pageSize = 10000;
      }
      this.filterCollection(new_state_obj);
      if (new_state_obj.printing) {
        this.setState(new_state_obj, window.print);
      } else {
        this.setState(new_state_obj);
      }
      return this.setQuery(new_state_obj);
    },
    filterCollection: function(new_state) {
      var config, pageIndex, pageSize, reset_collection;
      reset_collection = true;
      if (!new_state) {
        new_state = this.state;
      }
      config = {};
      config.where = {
        category: new_state.category || this.state.category
      };
      if (new_state.searchTxt) {
        config.filter = function(model) {
          return model.searchStr.indexOf(new_state.searchTxt) > -1;
        };
      }
      pageSize = new_state.pageSize || this.state.pageSize;
      if (typeof new_state.pageIndex === 'number') {
        pageIndex = new_state.pageIndex;
      } else {
        pageIndex = this.state.pageIndex;
      }
      config.limit = pageSize;
      config.offset = pageIndex * pageSize;
      return this.props.collection.configure(config, reset_collection);
    },
    render: function() {
      if (!this.isMounted()) {
        this.filterCollection();
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
