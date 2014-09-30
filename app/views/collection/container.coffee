React = require 'react/addons'
cx = React.addons.classSet
{p, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

Standard = require './standard'
Search = require './search'

module.exports = React.createClass

  topTxt: ->
    if @props.initState.section == 'summer'
      return ul
        className: 'summer-txt',
          li 'Browse Summer Sale items from the collections below.'
          li 'Limited stock. Contact Customer Service for details.'
          li 'All sales are final and fabric is sold as is.'
    else if @props.initState.searchTxt
      return false
    else
      return p
        className: 'text-area',
          'Browse the collection by category below.'

  render: ->
    category = @props.initState.category
    isOnTrim = 'passementerie' == category
    props = _.extend @props,
      threeUp: 3 == @props.initState.pgSize and @props.collection.models[1] and @props.collection.models[1].id
      isOnTrim: isOnTrim
      extraButtons: isOnTrim or 3 == @props.initState.pgSize

    if @props.initState.searchTxt
      content = Search props
    else
      content = Standard props

    classes = cx
      collection: true
      summer: @props.initState.section == 'summer'
    div
      id: 'container-collection'
      className: classes,
        @topTxt()
        content
