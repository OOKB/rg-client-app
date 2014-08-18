AmpersandModel = require("ampersand-model")
_ = require 'underscore'

cdn = '//img.rg.cape.io/'

module.exports = AmpersandModel.extend
  props:
    approx_size: 'string' # Leather
    approx_thick: 'string' # Leather
    approx_width: 'string'
    color_id: ['string', true] # 02
    color: 'string' # Color name.
    colors: 'array'
    category: ['string', true] # textile, leather, passementerie
    content: 'array'
    contents: 'string'
    design: 'string'
    design_descriptions: 'array'
    far: ['boolean', true, false]
    _file: 'object'
    hasDetail: ['boolean', true, false]
    hasImage: ['boolean', true, false]
    id: ['string', true]
    label: 'string'
    name: 'string' # Pattern name.
    order: ['number', true, 99999]
    use: 'array'
    patternNumber: ['string', true]
    price: 'number'
    repeat: 'string'
    ruler: ['string', true]

  parse: (item) ->
    item.id = item.patternNumber+'-'+item.color_id
    if item._file
      item.hasImage = true
      if item.category != 'passementerie'
        item.hasDetail = true
      prefix = cdn + 'items/'+item.id
      if item._file.small
        item._file.small.path = prefix + '/640.jpg'
        item._file.small.width = 640
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
        item._file.large.width = 1536
        if item.far
          item._file.large.path_far = prefix + '/far/1536.jpg'

      if item._file.xlarge
        item._file.xlarge.path = prefix + '/2560.jpg'
        if item.far
          item._file.xlarge.path_far = prefix + '/far/2560.jpg'
    return item

  derived:
    searchStr:
      deps: ['id', 'color', 'name', 'content']
      fn: ->
        if 'leather' == @category
          content = @contents
        else
          content = @content
        (@id + ' ' + @name + ' ' + @color + ' ' + content).toLowerCase()

    detail:
      deps: ['patternNumber', 'color_id', 'id']
      fn: ->
        if @hasImage
          if 'passementerie' == @category
            return '#collection/passementerie/21/p0?id='+@id
          else
            return '#detail/'+@patternNumber+'/'+@color_id
        else
          return null

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
