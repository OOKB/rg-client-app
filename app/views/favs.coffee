React = require 'react'
{p, h3, div, ul, li, button} = require 'reactionary'
_ = require 'underscore'

module.exports = React.createClass

  render: ->
    v = @props.initState
    if v.ids
      content = p 'favs list'
    else
      content = p 'No favorites found.'
    favsMenu = ul
      className: 'favs-menu',
        li
          className: 'hug-center',
            h3
              className: 'uppercase',
                'Favorites'
    div
      id: 'container-favs',
        p
          key: 'intro'
          className: 'text-area',
            'Browse and edit your favorites.'
        favsMenu
        content
