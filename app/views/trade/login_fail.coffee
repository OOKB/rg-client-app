React = require 'react'
{div, p} = require 'reactionary'

Close = require '../el/button_close'

module.exports = React.createClass
  propTypes:
    onClick: React.PropTypes.func.isRequired

  render: ->
    div
      className: "login-failed alert alert-dismissable",
        Close
          onClick: @props.onClick
        p 'Login failed'
