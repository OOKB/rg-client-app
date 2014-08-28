React = require 'react'
{div, p, ul, li, i, a} = require 'reactionary'

Button = require './button'
FavButton = require './button_fav'

# Item action buttons.
module.exports = React.createClass

  propTypes:
    itemState: React.PropTypes.object.isRequired
    initState: React.PropTypes.object.isRequired
    model: React.PropTypes.object.isRequired
    setItemState: React.PropTypes.func.isRequired
    buttonsFor: React.PropTypes.string.isRequired
    extraButtons: React.PropTypes.bool.isRequired

  colorsClick: (e) ->
    @props.setItemState
      infoBoxView: false
      colorBoxView: !@props.itemState.colorBoxView

  infoClick: ->
    @props.setItemState
      colorBoxView: false
      infoBoxView: !@props.itemState.infoBoxView

  data: (buttonType) ->
    switch buttonType
      when 'color'
        key: 'colors'
        name: 'item-colors'
        value: 'patternNumber'
        onClick: @colorsClick
        label: 'Colors'
      when 'info'
        key: 'item-info'
        name: 'item-details'
        onClick: @infoClick
        label: '='

  # Template for the buttons container.
  el: (child) ->
    div
      className: 'item-icons hidden-xs',
        child

  render: ->
    buttonsFor = @props.buttonsFor
    section = @props.initState.section
    item = @props.model
    favsOnly = @props.favsOnly
    extraButtons = @props.extraButtons
    initState = @props.initState
    itemState = @props.itemState
    unless buttonsFor == item.id
      return false

    favThisButton = FavButton
      key: 'fav'
      model: item
      setItemState: @props.setItemState
      itemState: itemState

    # Simply return the favs button.
    if favsOnly or not extraButtons
      return @el favThisButton

    # Possible buttons to display.
    buttonTypes = @props.buttonTypes or ['color', 'fav', 'info']

    # Array to pass to @el()
    buttons = []
    buttonTypes.forEach (buttonType) =>
      if 'fav' == buttonType
        buttons.push favThisButton
      else
        btn = @data(buttonType)
        # Set if active be added to the className.
        active = itemState[buttonType+'BoxView'] or false
        if 'color' == buttonType and initState.patternNumber
          active = true
        buttons.push Button
          key: btn.key
          model: item
          buttonInfo: btn
          active: active
    # Return all the buttons.
    return @el buttons
