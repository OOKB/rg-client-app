AmpersandModel = require("ampersand-model")
_ = require 'lodash'

module.exports = AmpersandModel.extend
  props:
    approx_width: "string"
    color_id: ["string", true] # 02
    color: "string" # Color name.
    colors: 'array'
    category: ["string", true] # textile, leather...
    content: "string"
    contents: "string"
    design: "string"
    design_descriptions: "array"
    _file: "object" # Pattern name.
    name: 'string'
    use: "array"
    patternNumber: ['string', true]
    price: 'number'
    repeat: 'string'

  # parse: (item) ->
  #   item

  derived:
    id: # If this doesn't work here move to parse func.
      deps: ['patternNumber', 'color_id']
      fn: ->
        @patternNumber+'-'+@color_id
    searchStr:
      deps: ['id', 'color', 'name']
      fn: ->
        (@id + ' ' + @name + ' ' + @color + ' ' + @content).toLowerCase()
