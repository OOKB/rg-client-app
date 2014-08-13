module.exports = (items, filters, defaults) ->
  resetCollection = true
  config =
    where:
      category: filters.category or defaults.category

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
