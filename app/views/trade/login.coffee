React = require 'react'
{div, p, form} = require 'reactionary'

FieldTxt = require '../el/form_text'

module.exports = React.createClass
  submitLogin: ->
    user = @refs.email.getDOMNode().value
    pass = @refs.password.getDOMNode().value
    console.log user, pass

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
              placeholder: 'Email or Account Number'
            FieldTxt
              fieldType: 'password'
              label: 'Password or Zip Code'
              id: 'password'
              placeholder: 'Password'
            button
              className: 'btn btn-default uppercase'
              type: 'submit',
                'Log In'
