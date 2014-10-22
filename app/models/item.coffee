AmpersandModel = require("ampersand-model")
_ = require 'lodash'

cdn = '//rogersandgoffigon.imgix.net/'

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
    itemComments: 'string'
    label: 'string'
    name: 'string' # Pattern name.
    order: ['number', true, 99999]
    use: 'array'
    patternNumber: ['string', true]
    price: 'number'
    repeat: 'string'
    related: 'array'
    ruler: ['string', true]
    summerSale: ['boolean', true, false]

  parse: (item) ->
    # Set ID.
    item.id = item.patternNumber+'-'+item.color_id
    if itemOrder = app.itemOrder[item.id]
      item.order = itemOrder
    related = app.patternColors[item.patternNumber]
    # Remove self from related.
    item.related = _.without related, item.color_id
    if item.category == 'passementerie'
      item.name = null
    if item.itemComments
      if item.itemComments[0] and not item.itemComments[1]
        item.itemComments = item.itemComments[0]
      else if item.itemComments[1] and not item.itemComments[0]
        item.itemComments = item.itemComments[1]
      else if item.itemComments[0] and item.itemComments[1]
        item.itemComments = item.itemComments.join(', ')
    #console.log item.itemComments
    if item.imgPath
      item._file = {}
      item.hasImage = true
      item.hasDetail = true
      prefix = cdn + item.imgPath
      item._file.thumb =
        width: 100
        height: 100
        path: prefix + '?w=100&h=100&fit=crop'
      if item.category != 'passementerie'
        item._file.small =
          path: prefix + '?w=1170'
          width: 1170
      else
        item._file.small =
          path: prefix + '?w=640'
          width: 640
      item._file.large =
        path: prefix + '?w=1536'
        width: 1536
      item._file.xlarge =
        path: prefix + '?w=2560'
        width: 2560

      if item.far
        item._file.small.path_far = prefix + '/far/'+item.id+'.jpg?w=640'
        item._file.large.path_far = prefix + '/far/'+item.id+'.jpg?w=1536'
        item._file.large.path_far = prefix + '/far/'+item.id+'.jpg?w=2560'

    return item

  derived:
    searchStr:
      deps: ['id', 'color', 'name', 'content']
      fn: ->
        if 'leather' == @category
          content = @contents
        else
          content = @content
        if @colors and @colors.length
          color = @colors.join(' ')
        else
          color = ''
        str = color + ' ' + @id + ' ' + @name + ' ' + @color + ' ' + content
        str.toLowerCase()

    detail:
      deps: ['patternNumber', 'color_id', 'id']
      fn: ->
        if @hasImage
          return '#detail/'+@patternNumber+'/'+@color_id
        else
          return null

    collectionLink:
      deps: ['id', 'category']
      fn: ->
        if @hasImage
          return '#collection/'+@category+'/12/p0?id='+@id
        else
          return null

    priceDisplay:
      deps: ['price']
      cache: false
      fn: ->
        if app.me.loggedIn
          price = '$'+@price
          if @category == 'leather'
            price += ' sq ft'
          price
        else
          'n/a'

    rulerPath:
      deps: ['ruler']
      fn: ->
        rulerCdn = '//img.rg.cape.io/'
        inch:
          large: rulerCdn+'media/ruler/inch/'+@ruler+'-1536.png'
          xlarge: rulerCdn+'media/ruler/inch/'+@ruler+'-2560.png'
        cm:
          large: rulerCdn+'media/ruler/cm/'+@ruler+'-1536.png'
          xlarge: rulerCdn+'media/ruler/cm/'+@ruler+'-2560.png'

    # Decide if it has related colors.
    hasRelated:
      deps: ['related']
      fn: ->
        if @related.length then true else false

    splitContents:
      deps: ['contents']
      fn: ->
        lines = []
        newLine = true
        # Split on spaces
        arr = @contents.split(' ')
        last = arr.length - 1
        line = ''
        arr.forEach (word, i) ->
          if !isNaN(word.substr(0, 1)) or word == 'Total'
            if line
              if word == '1/2%'
                line += ' ' + word
              else
                lines.push line+'<br />'
                line = word
            else
              line = word
          else if _.contains word, ':'
            section = word.split(':')
            lines.push line+' '+section[0]+':<br />'
            line = section[1] or ''
          else
            line += ' ' + word
          if last == i
            lines.push line
        return lines.join('')

    splitRepeat:
      deps: ['repeat']
      fn: ->
        r = @repeat
        if _.contains r, ' V'
          r.replace ' V', '<br />V'
        else if _.contains r, ' H'
          r.replace ' H', '<br />H'
        else
          r
