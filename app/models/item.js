(function() {
  var AmpersandModel, _;

  AmpersandModel = require("ampersand-model");

  _ = require('lodash');

  module.exports = AmpersandModel.extend({
    props: {
      approx_width: "string",
      color_id: ["string", true],
      color: "string",
      colors: 'array',
      category: ["string", true],
      content: "string",
      contents: "string",
      design: "string",
      design_descriptions: "array",
      _file: "object",
      name: 'string',
      use: "array",
      patternNumber: ['string', true],
      price: 'number'
    },
    derived: {
      id: {
        deps: ['patternNumber', 'color_id'],
        fn: function() {
          return this.patternNumber + '-' + this.color_id;
        }
      },
      searchStr: {
        deps: ['id', 'color', 'name'],
        fn: function() {
          return (this.id + ' ' + this.name + ' ' + this.color).toLowerCase();
        }
      }
    }
  });

}).call(this);
