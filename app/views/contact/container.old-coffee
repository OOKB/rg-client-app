React = require 'react'
{div, p, a, h2, button, ul, li} = require 'reactionary'

Showrooms = require './showrooms'

module.exports = React.createClass

  render: ->
    console.log @props
    console.log 'contact page?'
    div
      className: 'contact'
      div
        className: 'toggle showrooms',
          h2 'Showrooms & Representatives'
          div
            className: 'slider',
              # this is presumably then where "showrooms" would render
              ul
                className: 'top list-inline '
                  li 'somehow generate these from yaml lists?'
              ul
                className: 'north-america list-inline '
                  li 'somehow generate these from yaml lists?'
              ul
                className: 'europe-aust list-inline '
                  li 'somehow generate these from yaml lists?'
      div
        className: 'toggle showrooms',
          h2 'General Inquiries'
          div
            className: 'slider',
              p 'Please contact your local showroom or representative.'
              p 'For inquiries outside represented areas contact us at: 203-532-8068'
