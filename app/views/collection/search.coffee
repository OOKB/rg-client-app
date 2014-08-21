React = require 'react'
{p, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

Row = require './row'

module.exports = React.createClass

  render: ->
    div
      id: 'container-collection'
      className: 'collection',
        'Text search! Bam.'
