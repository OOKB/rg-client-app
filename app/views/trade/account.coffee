React = require 'react'
{div, p, a, h3} = require 'reactionary'

module.exports = React.createClass

  acctWrap: (label, el) ->
    div
      className: 'account-item',
        h3
          className: 'uppercase',
            label
        el

  editable: (value, id) ->
    a
      class: 'editable editable-click'
      id: id
      role: 'button',
        value

  render: ->
    div
      className: 'trade-acct text-center',
        div
          className: 'text-area text-center add-bottom',
            p 'View and update your account information below.'
        div
          className: 'account-information',
            @acctWrap 'Account Number', '034655'
            @acctWrap 'Email', @editable('me@you.com', 'email')
            @acctWrap 'Phone', @editable('612-555-1234', 'phone')
            @acctWrap 'Address', @editable('123 Main St, New York, NY 10001', 'address')
            @acctWrap 'Password', @editable('hidden', 'password')
            @acctWrap 'Sales Representative', 'Dr. King'
