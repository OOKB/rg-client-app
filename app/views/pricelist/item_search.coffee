React = require 'react'
{form, input, p, div, button, select, option, ul, li, a} = require 'reactionary'
_ = require 'lodash'

Pager = require './pager'
CategoryMenu = require '../el/category_menu'
# props
## onUserInput() - defined in item_container.

module.exports = React.createClass

  handleChange: (event) ->
    @props.onUserInput
      searchTxt: @refs.filterTextInput.getDOMNode().value

  handleCollectionClick: (e) ->
    collection_id = e.target.value
    if e.preventDefault
      e.preventDefault()
    @props.onUserInput
      category: collection_id

  render: ->
    v = @props.filter # see item_container.coffee for example object.

    return form {},

      CategoryMenu _.extend v, key: 'cat-menu'
      div
        className: 'pricelist-header',
          Pager initState: v
