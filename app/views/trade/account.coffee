React = require 'react'
{div, p} = require 'reactionary'

module.exports = React.createClass

  render: ->
    div
      className: 'trade-login text-center col-sm-8 col-sm-offset-2',
        div
          className: 'page-content',
            p
              className: 'description',
                'acct pg.'
