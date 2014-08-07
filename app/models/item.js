(function() {
  var AmpersandModel, cdn, _;

  AmpersandModel = require("ampersand-model");

  _ = require('lodash');

  cdn = '//img.rg.cape.io/';

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
      far: ['boolean', true, false],
      _file: "object",
      label: 'string',
      name: 'string',
      use: "array",
      patternNumber: ['string', true],
      price: 'number',
      repeat: 'string',
      ruler: ['string', true]
    },
    parse: function(item) {
      var prefix;
      item.id = item.patternNumber + '-' + item.color_id;
      if (item._file) {
        prefix = cdn + 'items/' + item.id;
        if (item._file.small) {
          item._file.small.path = prefix + '/640.jpg';
          if (item.far) {
            item._file.small.path_far = prefix + '/far/640.jpg';
          }
        }
        if (item._file.large) {
          item._file.large.path = prefix + '/1536.jpg';
          if (item.far) {
            item._file.large.path_far = prefix + '/far/1536.jpg';
          }
        }
        if (item._file.xlarge) {
          item._file.xlarge.path = prefix + '/2560.jpg';
          if (item.far) {
            item._file.xlarge.path_far = prefix + '/far/2560.jpg';
          }
        }
      }
      return item;
    },
    derived: {
      searchStr: {
        deps: ['id', 'color', 'name'],
        fn: function() {
          return (this.id + ' ' + this.name + ' ' + this.color + ' ' + this.content).toLowerCase();
        }
      },
      detail: {
        deps: ['patternNumber', 'color_id'],
        fn: function() {
          return '#detail/' + this.patternNumber + '/' + this.color_id;
        }
      }
    }
  });

}).call(this);
