React = require 'react/addons'
cx = React.addons.classSet
{p, div, ul, li, button} = require 'reactionary'
_ = require 'lodash'

Standard = require './standard'
Search = require './search'

module.exports = React.createClass

  topTxt: ->
    if @props.initState.section == 'summer'
      return ul
        className: 'summer-txt',
          li 'Browse Summer Sale items from the collections below.'
          li 'Limited stock, 5 yard minimum required. Fabric is sold as is. No returns or samples. Your CFA will serve as your sample for all Summer Sale items. Please contact Customer Service in Connecticut at 203-532-8068, for more information.'
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
