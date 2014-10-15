_ = require 'lodash'

filterCatProp =
  color: 'colors'
  content: 'content'
  description: 'design_descriptions'
  type: 'name'
  use: 'use'

setFilterFields = (items, filterOps, filterFields) ->
  filterOps.forEach (cat) ->
    if filterFields and f = filterCatProp[cat]
      filterFields[cat] = _.compact(_.uniq(_.flatten(items.pluck(f)))).sort()
  return

# Intelligently filter items based on state.

module.exports = (items, filters) ->
  setRemainingFilters = false

  config =
    where: {}

  if filters.category
    config.where.category = filters.category

  # Require that the item has a detail page.
  if filters.hasDetail
    config.where.hasDetail = true

  # When viewing items in collection or summer requires img and color sort.
  if 'collection' == filters.section or 'summer' == filters.section
    filters.hasImage = true
    config.comparator = 'order'
  # Always sort trim on pricelist by the itemNumber.
  else if 'pricelist' == filters.section and 'passementerie' == filters.category
    config.comparator = 'id'
  # Otherwise leave the sort as the default whatever thing.
  else
    config.comparator = undefined

  # Require that item has an image.
  if filters.hasImage
    config.where.hasImage = true

  config.filters = []
  config.filters.push (model) ->
    model.color_id.substring(0, 2) != '00'

  # Summer sale items.
  if filters.section == 'summer'
    # When the section is summer only show summer items.
    config.where.summerSale = true
    # Show remaining active filters since summer sale is a subset of items.
    setRemainingFilters = true
    # Limit available filters.
    if filters.filterOptions
      items.configure config, true
      setFilterFields items, filters.filterOptions, filters.filterFields
  # All sections besides 'detail' should filter out summer items.
  else if filters.section != 'detail'
    config.where.summerSale = false

  # Only show items belonging to a specific pattern.
  # This functionality is only used on the detail page.
  if filters.patternNumber
    config.where.patternNumber = filters.patternNumber
    setRemainingFilters = true

  # Collection / Summer / Pricelist
  if filters.searchTxt
    setRemainingFilters = true
    if 'x-no-img' == filters.searchTxt
      config.where.hasImage = false
    if 'x-letter-ids'
      config.filters.push (model) ->
        !/^(P-|L-)?[0-9]{4,7}-[0-9]{2}$/.test(model.id)
    else
      config.filters = filters.searchTxt.split(' ').map (searchTxt) ->
        (model) ->
          model.searchStr.indexOf(searchTxt) > -1

  # Favs
  if filters.ids and filters.ids.length
    config.filters.push (model) ->
      _.contains filters.ids, model.id

  # Filter boxes
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

  # When is this used?
  if filters.id and not filters.patternNumber
    config =
      where:
        id: filters.id

  # FILTER THE ITEMS
  #console.log config
  items.configure config, true
  #console.log items.length
  # Set remaining available filters that will return results.
  if setRemainingFilters and filters.filterOptions
    unless filters.possibleFilters
      filters.possibleFilters = {}
    setFilterFields items, filters.filterOptions, filters.possibleFilters
  else
    filters.possibleFilters = filters.filterFields
    filters.selectedFilters = {}

  # NOW CUT TO SIZE

  if items.length > 1 and filters.pgSize and filters.pageIndex
    sizeConfig = {}
    pgSize = filters.pgSize
    pageIndex = filters.pageIndex - 1
    sizeConfig.limit = pgSize
    if pgSize == 3
      sizeConfig.offset = pageIndex - 1
      sizeConfig.loop = true
    else
      sizeConfig.offset = pageIndex * pgSize
    items.configure sizeConfig, false

  #console.log config

  return
