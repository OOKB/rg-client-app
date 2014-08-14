module.exports = (items, filters, defaults) ->
  resetCollection = true

  unless filters.category
    filters.category = defaults.category

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

  if filters.searchTxt
    config.filters = filters.searchTxt.split(' ').map (searchTxt) ->
      (model) ->
        model.searchStr.indexOf(searchTxt) > -1

  pgSize = filters.pgSize or defaults.pgSize
  if typeof filters.pageIndex == 'number'
    pageIndex = filters.pageIndex
  else
    pageIndex = defaults.pageIndex

  config.limit = pgSize
  config.offset = pageIndex * pgSize
  items.configure config, resetCollection
  return
