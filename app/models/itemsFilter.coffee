module.exports = (items, filters, defaults) ->
  resetCollection = true

  unless filters.category
    filters.category = defaults.category
  filters.category = switch filters.category
    when 't' then 'textile'
    when 'textile' then 'textile'
    when 'p' then 'passementerie'
    when 'passementerie' then 'passementerie'
    when 'trim' then 'passementerie'
    when 'l' then 'leather'
    when 'leather' then 'leather'
    else 'textile'

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

  pageSize = filters.pageSize or defaults.pageSize
  if typeof filters.pageIndex == 'number'
    pageIndex = filters.pageIndex
  else
    pageIndex = defaults.pageIndex

  config.limit = pageSize
  config.offset = pageIndex * pageSize
  items.configure config, resetCollection
  return
