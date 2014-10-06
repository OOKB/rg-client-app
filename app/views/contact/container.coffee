React = require 'react'
{div, p, a, h3, button, img} = require 'reactionary'

module.exports = React.createClass

  render: ->
    console.log @props
    console.log "contact page?"
    div
      className: 'contact'
      div
        className: 'toggle showrooms',
          h2
            "Showrooms & Representatives"
          div
            className: 'slider',
              ul
                className: 'top list-inline '
              ul
                className: 'north-america list-inline '
              ul
                className: 'europe-aust list-inline '
      div
        className: 'toggle showrooms',
          h2
            "Showrooms & Representatives"
          div
            classNameL 'slider',
              p
                "Please contact your local showroom or representative."
              p
                "For inquiries outside represented areas contact us at: 203-532-8068"
