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
          li 'Contact Customer Service for Inventory - 203-532-8068'
          li '5 Yard Minimum'
          li 'Limited Quantities'
          li 'Your CFA is Your Sample'
          li 'Reserves are for 10 Days Only'
          li 'Shipping Charges Apply'
          li '•'
          li 'NO RETURNS'
          li 'ALL FABRIC SOLD AS IS'
          li 'ALL SALES FINAL'
          li 'PAYMENT BY CHECK OR CREDIT CARD'
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
