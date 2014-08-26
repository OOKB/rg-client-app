React = require 'react'
{nav, div, button, h3, p, span, ul, li} = require 'reactionary'

Info = require '../el/info'
FavButton = require '../el/button_fav'

module.exports = React.createClass

  handleXclick: ->
    window.history.back()

  render: ->
    nav className: 'item-detail-header',
      div className: 'controls',
        ul {},
          li className: 'fav',
            button className: 'fav', '+'
          li className: 'close',
            button
              className: 'close'
              type: 'button'
              onClick: @handleXclick
              'area-hidden': 'true',
                'X'
        h3 className: 'hidden-md hidden-lg', 'Details'
        button
          className: 'toggle hidden-md hidden-lg'
          type: 'button',
            'Reveal Menu'
      div className: 'item-detail-content',
        Info @props
