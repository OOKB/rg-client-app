module.exports = (items, filters) ->
  resetCollection = true

  config =
    where: {}

  # Only show items belonging to a specific pattern.
  if filters.patternNumber
    config.where.patternNumber = filters.patternNumber

  # Only show items with a specific color id.
  # if filters.color_id
  #   config.where.color_id = filters.color_id
  # else if filters.initColor
  #   config.where.color_id = filters.initColor

  if filters.category
    config.where.category = filters.category

  # Require that the item has a detail page.
  if filters.hasDetail
    config.where.hasDetail = true

  # Require that item has an image.
  if filters.hasImage
    config.where.hasImage = true

  if filters.colorSorted
    config.comparator = 'order'

  config.filters = []
  if filters.searchTxt
    config.filters = filters.searchTxt.split(' ').map (searchTxt) ->
      (model) ->
        model.searchStr.indexOf(searchTxt) > -1
  if filters.omit00
    config.filters.push (model) ->
      model.color_id.substring(0, 2) != '00'

  if filters.pgSize and filters.pageIndex
    pgSize = filters.pgSize
    pageIndex = filters.pageIndex - 1
    config.limit = pgSize
    config.offset = pageIndex * pgSize

  if filters.id
    config =
      where:
        id: filters.id

  items.configure config, resetCollection
  return
