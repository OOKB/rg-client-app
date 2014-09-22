React = require 'react'
{div, p} = require 'reactionary'
_ = require 'lodash'
SubCollection = require 'ampersand-subcollection'

Items = require './collection/items'

module.exports = React.createClass

  render: ->
    v = @props.initState
    if v.ids and v.ids.length
      content = []
      favs = @props.collection
      categories = ['textile', 'leather', 'passementerie']
      categories.forEach (cat) =>
        isOnTrim = 'passementerie' == cat
        items = new SubCollection(favs, where: category: cat)
        if items.length
          props =
            collection: items
            key: cat
            category: cat
            isOnTrim: isOnTrim
            extraButtons: isOnTrim
          content.push Items _.extend(@props, props)
      div content
    else
      p 'No favorites found.'
