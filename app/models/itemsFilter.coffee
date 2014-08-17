module.exports = (items, filters) ->
  resetCollection = true

  config =
    where:
      category: filters.category

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


  pgSize = filters.pgSize
  pageIndex = filters.pageIndex - 1

  config.limit = pgSize
  config.offset = pageIndex * pgSize
  items.configure config, resetCollection
  return
