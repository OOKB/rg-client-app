React = require 'react'
{div, p, a, form, button} = require 'reactionary'

FieldTxt = require '../el/form_text'

module.exports = React.createClass

  submitLogin: (e) ->
    if e.preventDefault
      e.preventDefault()

    app.me.username = @refs.username.getDOMNode().querySelector('input').value
    password = @refs.password.getDOMNode().querySelector('input').value
    app.me.login(password)

  handleEmail: (e) ->
    app.me.username = e.target.value

  handlePassword: (e) ->
    app.me.password = e.target.value

  render: ->
    div
      className: 'trade-login text-center col-sm-8 col-sm-offset-2',
        div
          className: 'page-content',
            p
              className: 'description',
                'Login to access the trade section of site.'
            p
              className: 'more-info',
                a
                  href: '#trade',
                    'More info'
        form
          className: 'form-inline'
          role: 'form',
            FieldTxt
              fieldType: 'text'
              label: 'Email or Account Number'
              id: 'email'
              ref: 'username'
              placeholder: 'Email or Account Number'
              onChange: @handleEmail
              value: app.me.username
            FieldTxt
              fieldType: 'password'
              label: 'Password or Zip Code'
              id: 'password'
              placeholder: 'Password'
              onChange: @handlePassword
              value: app.me.password
              ref: 'password'
            button
              onClick: @submitLogin
              className: 'btn btn-default uppercase'
              type: 'submit',
                'Log In'
