React = require 'react'
{button} = require 'reactionary'

Button = require './button'

# Action buttons

module.exports = React.createClass

  propTypes:
    model: React.PropTypes.object.isRequired
    itemState: React.PropTypes.object.isRequired
    setItemState: React.PropTypes.func.isRequired

  addToFavs: (e) ->
    id = e.target.value
    #console.log 'addFav '+e.target.value
    app.me.addFav id
    @props.setItemState
      infoBoxView: false
      colorBoxView: false
      favBoxView: id

  rmFav: (e) ->
    id = e.target.value
    app.me.rmFav id
    @props.setItemState favBoxView: false

  data: (buttonType) ->
    switch buttonType
      when 'addFav'
        key: 'favs'
        name: 'item-favorite btn-large'
        value: 'id'
        onClick: @addToFavs
        label: '+'
      when 'rmFav'
        key: 'remove'
        name: 'remove-item btn-large'
        value: 'id'
        onClick: @rmFav
        label: '-'

  # Template for the button itself.
  # btn is one of the objects from @data above ^.
  # active is boolean.
  render: ->
    item = @props.model
    # Define based on if user has them in favs.
    if app.me.hasFav item.id
      buttonInfo = @data('rmFav')
    else
      buttonInfo = @data('addFav')

    Button
      model: item
      buttonInfo: buttonInfo
      active: @props.itemState.favBoxView != false
