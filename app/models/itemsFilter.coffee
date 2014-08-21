_ = require 'lodash'

filterCatProp =
  color: 'colors'
  content: 'content'
  description: 'design_descriptions'
  type: 'name'

setFilterFields = (items, filterOps, filterFields) ->
  filterOps.forEach (cat) ->
    if f = filterCatProp[cat]
      filterFields[cat] = _.compact(_.uniq(_.flatten(items.pluck(f)))).sort()
  return

module.exports = (items, filters) ->
  resetCollection = true
  setRemainingFilters = false

  config =
    where: {}

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

  if filters.filterOptions
    items.configure config, true
    setFilterFields items, filters.filterOptions, filters.filterFields

  # Only show items belonging to a specific pattern.
  if filters.patternNumber
    config.where.patternNumber = filters.patternNumber
    setRemainingFilters = true

  config.filters = []
  if filters.searchTxt
    setRemainingFilters = true
    config.filters = filters.searchTxt.split(' ').map (searchTxt) ->
      (model) ->
        model.searchStr.indexOf(searchTxt) > -1

  if filters.omit00
    config.filters.push (model) ->
      model.color_id.substring(0, 2) != '00'

  if filters.ids and filters.ids.length
    config.filters.push (model) ->
      _.contains filters.ids, model.id

  if filters.selectedFilters
    _.forEach filters.selectedFilters, (selectedFilters, filterCat) ->
      if selectedFilters and _.isArray(selectedFilters) and selectedFilters.length
        setRemainingFilters = true
        if 'type' == filterCat
          config.where.name = selectedFilters[0]
        else
          config.filters.push (model) ->
            fid = filterCatProp[filterCat]
            _.difference(selectedFilters, model[fid]).length == 0

  if filters.pgSize and filters.pageIndex
    pgSize = filters.pgSize
    pageIndex = filters.pageIndex - 1
    config.limit = pgSize
    if pgSize == 3
      config.offset = pageIndex
    else
      config.offset = pageIndex * pgSize

  if filters.id
    config =
      where:
        id: filters.id

  #console.log config

  items.configure config, resetCollection

  if setRemainingFilters and filters.filterOptions
    setFilterFields items, filters.filterOptions, filters.possibleFilters
  else
    filters.possibleFilters = filters.filterFields
    filters.selectedFilters = {}
  return
