React = require 'react/addons'
cx = React.addons.classSet
{div, button, p, span} = require 'reactionary'

CloseButton = require '../el/button_close'

module.exports = React.createClass

  notes: ->
    div
      id:"item-notes",
        CloseButton
          onClick: => @props.setParentState showNotes: false
        p
          @props.notes

  render: ->
    if @props.showNotes
      notes = @notes()
    else
      notes = false
    classes = cx
      uppercase: true
      active: @props.showNotes
    div
      className: "toggle-notes hidden-xs",
        button
          onClick: => @props.setParentState
            showNotes: !@props.showNotes
            colorBoxView: false
          className: classes,
            'Notes'
        notes
