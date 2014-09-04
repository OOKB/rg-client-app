React = require 'react'
{div, p} = require 'reactionary'

module.exports = React.createClass

  render: ->
    div
      className: 'trade-login text-center',
        div
          className: 'page-content',
            p
              className: 'description',
                'acct pg.'
