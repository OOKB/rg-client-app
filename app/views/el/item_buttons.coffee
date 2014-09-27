React = require 'react'
{div, p, ul, li, i, a} = require 'reactionary'
_ = require 'lodash'

Button = require './button'
FavButton = require './button_fav'
ProjectButton = require './button_project'

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
        name: 'item-colors btn-text'
        value: 'patternNumber'
        onClick: @colorsClick
        label: 'Colors'
      when 'info'
        key: 'item-info'
        name: 'item-details btn-large'
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

    if app.me.loggedIn
      favThisButton = ProjectButton
        key: 'project'
        model: item
        setItemState: @props.setItemState
        itemState: itemState
        section: section
        projectId: initState.projectId
    else
      favThisButton = FavButton
        key: 'fav'
        model: item
        setItemState: @props.setItemState
        itemState: itemState

    # Simply return the favs button.
    if favsOnly or not extraButtons or section == 'projects'
      return @el favThisButton

    # Possible buttons to display.
    buttonTypes = @props.buttonTypes or ['color', 'fav', 'info']
    unless item.hasRelated
      buttonTypes = _.without buttonTypes, 'color'

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
