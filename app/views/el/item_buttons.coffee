React = require 'react'
{div, p, ul, li, button, img, i, a} = require 'reactionary'
_ = require 'lodash'

# Action buttons

module.exports = React.createClass

  propTypes:
    itemState: React.PropTypes.object.isRequired
    initState: React.PropTypes.object.isRequired
    model: React.PropTypes.object.isRequired
    setItemState: React.PropTypes.func.isRequired
    buttonsFor: React.PropTypes.string.isRequired
    extraButtons: React.PropTypes.bool.isRequired

  colorsClick: (e) ->
    if 'passementerie' == @props.initState.category
      if @props.initState.patternNumber
        @props.setRouterState
          patternNumber: false
      else
        @props.setRouterState
          patternNumber: e.target.value
    else
      @props.setItemState colorBoxView: !@props.itemState.colorBoxView

  addToFavs: (e) ->
    id = e.target.value
    #console.log 'addFav '+e.target.value
    app.me.addFav id
    @props.setItemState favBoxView: id

  rmFav: (e) ->
    id = e.target.value
    app.me.rmFav id

  infoClick: ->
    @props.setItemState infoBoxView: !@props.itemState.infoBoxView

  data: (buttonType) ->
    switch buttonType
      when 'addFav'
        key: 'favs'
        name: 'item-favorite'
        value: 'id'
        onClick: @addToFavs
        label: '+'
      when 'rmFav'
        key: 'remove'
        name: 'remove-item'
        value: 'id'
        onClick: @rmFav
        label: '-'
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

  # Template for the button itself.
  # btn is one of the objects from @data above ^.
  # active is boolean.
  createButtonEl: (item, btn, active) ->
    props =
      key: btn.key
      className: btn.name
      onClick: btn.onClick
    if active
      props.className += ' active'
    if btn.value and item[btn.value]
      props.value = item[btn.value]
    button props, btn.label

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
    # Define based on if user has them in favs.
    if app.me.hasFav item.id
      fav = 'rmFav'
    else
      fav = 'addFav'
    # Simply return the favs button.
    if favsOnly or not extraButtons
      return @el @createButtonEl(item, @data(fav), false)
    # Possible buttons to display.
    buttonTypes = ['color', fav, 'info']
    # Array to pass to @el()
    buttons = []
    buttonTypes.forEach (buttonType) =>
      btn = @data(buttonType)
      # Set if active be added to the className.
      active = itemState[buttonType+'BoxView']
      if 'color' == buttonType and initState.patternNumber
        active = true
      buttons.push @createButtonEl(item, btn, active)
    # Return all the buttons.
    return @el buttons
