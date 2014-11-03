React = require 'react'
{div, p, a, form, button} = require 'reactionary'

FieldTxt = require '../el/form_text'
Failed = require './login_fail'

module.exports = React.createClass
  getInitialState: ->
    showFailed: false

  submitLogin: (e) ->
    if e.preventDefault
      e.preventDefault()

    app.me.username = @refs.username.getDOMNode().querySelector('input').value
    password = @refs.password.getDOMNode().querySelector('input').value
    app.me.login(password)
    if @state.showFailed
      @setState showFailed: false
    return

  handleEmail: (val) ->
    app.me.username = val
    @setState username: val

  handlePassword: (val) ->
    app.me.password = val
    @setState username: val

  showFailure: ->
    @setState showFailed: true

  componentDidMount: ->
    app.me.on 'change:failedLogins', @showFailure

  componentWillUnmount: ->
    app.me.off 'change:failedLogins', @showFailure

  render: ->
    if @state.showFailed
      failure = Failed onClick: => @setState showFailed: false
    else
      failure = false
    div
      className: 'trade-login text-center',
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
              label: 'Account Number'
              id: 'email'
              ref: 'username'
              placeholder: 'Account Number'
              onChange: @handleEmail
              value: app.me.username
            FieldTxt
              fieldType: 'password'
              label: 'Zip Code'
              id: 'password'
              placeholder: 'Zip Code'
              onChange: @handlePassword
              value: app.me.password
              ref: 'password'
            button
              onClick: @submitLogin
              className: 'btn-outline'
              type: 'submit',
                'Log In'
        failure
