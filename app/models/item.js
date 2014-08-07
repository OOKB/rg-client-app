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
      far: 'boolean',
      _file: "object",
      label: 'string',
      name: 'string',
      use: "array",
      patternNumber: ['string', true],
      price: 'number',
      repeat: 'string',
      ruler: 'string'
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
          return (this.id + ' ' + this.name + ' ' + this.color + ' ' + this.content).toLowerCase();
        }
      }
    }
  });

}).call(this);
