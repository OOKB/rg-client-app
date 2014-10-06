React = require 'react'
{div, h3, address, p, ul, li} = require 'reactionary'

Showroom = require './showroom'

# this would then build an individual li.showroom
# it uses this: https://github.com/bjornmeansbear/rogers-and-goffigon/blob/master/content/contact/showrooms.yaml

li
  className: 'showroom',
    div
      h3 'TITLE (from yaml)'
      p 'NAME (from yaml)'
      # the old one printed out an address tag with <br/> breaking up the lines, ul is fine.
      ul
        className: 'address'
          li 'ADDRESS (from yaml)'
          li 'each line'
          li 'prints out'
          li 'as a line-item?'
      ul
        # these just print if they are there
        className: 'phone email fax'
          li 'EMAIL'
          li 'TEL'
          li 'FAX'
