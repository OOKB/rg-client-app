React = require 'react/addons'
cx = React.addons.classSet
{p, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

Standard = require './standard'
Search = require './search'

module.exports = React.createClass

  render: ->
    category = @props.initState.category
    isOnTrim = 'passementerie' == category
    props = _.extend @props,
      threeUp: 3 == @props.initState.pgSize and @props.collection.models[1].id
      isOnTrim: isOnTrim
      extraButtons: isOnTrim or 3 == @props.initState.pgSize

    if @props.initState.searchTxt
      content = Search props
      topTxt = false
    else
      content = Standard props
      topTxt = 'Browse the collection by category below.'
    if @props.initState.section == 'summer'
      topTxt = 'Browse Summer Sale items from the collections below.
          Limited stock, contact representative for details.
          All sales are final and fabric is sold as is.'
    classes = cx
      collection: @props.initState.section == 'collection'
      summer: @props.initState.section == 'summer'
    div
      id: 'container-collection'
      className: classes,
        p
          key: 'intro'
          className: 'text-area',
            topTxt
        content
