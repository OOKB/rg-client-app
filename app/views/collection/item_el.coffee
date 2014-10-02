React = require 'react'
{img, a} = require 'reactionary'

# Inner item template.

module.exports = React.createClass

  propTypes:
    model: React.PropTypes.object.isRequired
    imgSize: React.PropTypes.string.isRequired
    preventDetail: React.PropTypes.bool # Required when threeUp
    onClick: React.PropTypes.func
    onMouseDown: React.PropTypes.func
    onMouseOver: React.PropTypes.func

  # Item Image
  render: ->
    item = @props.model
    unless item.hasImage
      return false

    imgSize = @props.imgSize
    onClick = @props.onClick
    onMouseDown = @props.onMouseDown
    onMouseOver = @props.onMouseOver

    href = undefined

    if item.hasDetail and not @props.preventDetail
      # Has a detail page so link it.
      href = item.detail

    if item._file and not item._file[imgSize] and item._file.small
      imgSize = 'small'
    if item._file and item._file[imgSize]
      itemImg = img
        id: item.id
        alt: item.color
        width: item._file[imgSize].width
        height: item._file[imgSize].height
        src: item._file[imgSize].path,
        onMouseOver: @setButtonsFor
    else
      console.log item._file
      itemImg = 'No image available for the size '+imgSize
    a # Using an a tag because of all the possible mouse events.
      role: 'button' # Button because of events.
      onClick: onClick
      onMouseDown: onMouseDown
      onMouseOver: onMouseOver
      href: href,
        itemImg
