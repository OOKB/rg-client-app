_ = require 'lodash'

filterCatProp =
  color: 'colors'
  content: 'content'
  description: 'design_descriptions'
  type: 'name'

module.exports = (items, filters) ->
  resetCollection = true

  config =
    where: {}

  if filters.category
    config.where.category = filters.category
    if filters.filterOptions
      items.configure config, true
      filters.filterOptions.forEach (cat) ->
        if f = filterCatProp[cat]
          filters.filterFields[cat] = _.compact _.uniq(_.flatten(items.pluck(f)))

  # Only show items belonging to a specific pattern.
  if filters.patternNumber
    config.where.patternNumber = filters.patternNumber

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
  if filters.selectedFilters
    _.forEach filters.selectedFilters, (selectedFilters, filterCat) ->
      if selectedFilters and _.isArray selectedFilters
        #console.log filterCat
        config.filters.push (model) ->
          fid = filterCatProp[filterCat]
          _.difference(selectedFilters, model[fid]).length == 0
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
