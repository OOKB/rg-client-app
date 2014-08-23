React = require 'react'
{header, h1, a} = require 'reactionary'

Menu = require './menu'

# Header div
module.exports = React.createClass
  render: () ->
    title =
      h1 {},
        a
          href: '/',
            'Rogers & Goffigon'
    navigation = Menu @props
    header {}, title, navigation
