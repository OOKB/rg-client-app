AmpersandModel = require("ampersand-model")
_ = require 'lodash'

cdn = '//img.rg.cape.io/'

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
    far: ['boolean', true, false]
    _file: "object" # Pattern name.
    id: ['string', true]
    label: 'string'
    name: 'string'
    use: "array"
    patternNumber: ['string', true]
    price: 'number'
    repeat: 'string'
    ruler: ['string', true]

  parse: (item) ->
    item.id = item.patternNumber+'-'+item.color_id
    if item._file
      prefix = cdn + 'items/'+item.id
      if item._file.small
        item._file.small.path = prefix + '/640.jpg'
        if item.far
          item._file.small.path_far = prefix + '/far/640.jpg'
      else if item._file.wide
        item._file.small =
          path: prefix + '/1170.jpg'
          width: 1170
          height: item._file.wide.height
        delete item._file.wide
      if item._file.large
        item._file.large.path = prefix + '/1536.jpg'
        if item.far
          item._file.large.path_far = prefix + '/far/1536.jpg'

      if item._file.xlarge
        item._file.xlarge.path = prefix + '/2560.jpg'
        if item.far
          item._file.xlarge.path_far = prefix + '/far/2560.jpg'

    return item

  derived:
    searchStr:
      deps: ['id', 'color', 'name']
      fn: ->
        (@id + ' ' + @name + ' ' + @color + ' ' + @content).toLowerCase()

    detail:
      deps: ['patternNumber', 'color_id']
      fn: ->
        '#detail/'+@patternNumber+'/'+@color_id

    priceDisplay:
      deps: ['price']
      fn: ->
        '$'+@price

    rulerPath:
      deps: ['ruler']
      fn: ->
        inch:
          large: cdn+'media/ruler/inch/'+@ruler+'-1536.png'
          xlarge: cdn+'media/ruler/inch/'+@ruler+'-2560.png'
        cm:
          large: cdn+'media/ruler/cm/'+@ruler+'-1536.png'
          xlarge: cdn+'media/ruler/cm/'+@ruler+'-2560.png'
