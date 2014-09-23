React = require 'react'
{div, button, p, span} = require 'reactionary'

CloseButton = require '../el/button_close'

module.exports = React.createClass
  getInitialState: ->
    showNotes: false

  notes: ->
    div
      id:"item-notes",
        CloseButton
          onClick: => @setState showNotes: false
        p
          @props.notes

  render: ->
    if @state.showNotes
      notes = @notes()
    else
      notes = false
    div
      className: "toggle-notes hidden-xs",
        button
          onClick: => @setState showNotes: true
          className: "uppercase",
            'Notes'
        notes
