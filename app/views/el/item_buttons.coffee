React = require 'react'
{div, p, ul, li, i, a} = require 'reactionary'
_ = require 'lodash'

Button = require './button'
FavButton = require './button_fav'
ProjectButton = require './button_project'
OrderField = require './order'

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
    s =
      colorBoxView: !@props.itemState.colorBoxView
      infoBoxView: false
      projectBoxView: false
    @props.setItemState s

  infoClick: ->
    s =
      infoBoxView: !@props.itemState.infoBoxView
      favBoxView: false
      colorBoxView: false
      projectBoxView: false
    unless @props.model.category == 'passementerie'
      s.colorBoxView = false
    @props.setItemState s


  data: (buttonType) ->
    switch buttonType
      when 'color'
        key: 'colors'
        name: 'item-colors btn-text hidden-xs'
        value: 'patternNumber'
        onClick: @colorsClick
        label: 'Colors'
      when 'info'
        key: 'item-info'
        name: 'item-details btn-large hidden-xs'
        onClick: @infoClick
        label: '='

  # Template for the buttons container.
  el: (child, child2) ->
    div
      className: 'item-icons',
        child, child2

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

    adminOrder = false
    if app.me.loggedIn
      favThisButton = ProjectButton
        key: 'project'
        model: item
        setItemState: @props.setItemState
        itemState: itemState
        section: section
        projectId: initState.projectId
      if app.me.customerNumber == 'rogersandgoffigon'
        adminOrder = OrderField
          key: 'order'
          model: item
          initState: initState
    else
      favThisButton = FavButton
        key: 'fav'
        model: item
        setItemState: @props.setItemState
        itemState: itemState

    # Simply return the favs button.
    if favsOnly or not extraButtons
      return @el favThisButton, adminOrder

    # Possible buttons to display.
    buttonTypes = @props.buttonTypes or ['color', 'fav', 'info', 'admin']
    if section == 'projects' or not item.hasRelated
      buttonTypes = _.without buttonTypes, 'color'

    # Array to pass to @el()
    buttons = []
    buttonTypes.forEach (buttonType) =>
      if 'fav' == buttonType
        buttons.push favThisButton
      else if 'admin' == buttonType
        buttons.push adminOrder
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
