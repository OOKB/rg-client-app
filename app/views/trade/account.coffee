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
      className: 'editable editable-click'
      id: id
      role: 'button',
        value

  salesRep: (sr) ->
    #console.log sr
    if sr
      p sr.name, ' - ', sr.phoneNumber
    else
      false

  render: ->
    div
      className: 'trade-acct text-center',
        div
          className: 'text-area text-center add-bottom',
            p 'View and update your account information below.'
        div
          className: 'account-information',
            @acctWrap 'Account Number', app.me.customerNumber
            @acctWrap 'Email', @editable(app.me.email, 'email')
            @acctWrap 'Phone', @editable(app.me.phoneNumber, 'phone')
            @acctWrap 'Address', @editable('123 Main St, New York, NY 10001', 'address')
            @acctWrap 'Sales Representative', @salesRep(app.me.showroom)
