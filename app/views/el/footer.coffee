React = require 'react'
{footer, p, span, br, a} = require 'reactionary'
_ = require 'lodash'
# Footer div
module.exports = React.createClass

  disclaimerEl: ->
    unless @props.initState and @props.initState.section
      return false
    section = @props.initState.section
    disclaimerSections = ['favs', 'collection', 'summer', 'projects']
    if _.contains disclaimerSections, section
      if section == 'summer'
        lastLine = 'Please contact Customer Service in Connecticut for more information. '
      else
        lastLine = 'For inquiries outside represented areas contact us at: 203-532-8068'
      return disclaimerEl = p {},
          span 'Images shown may vary to actual.'
          br {}
          span 'Please contact your local showroom or representative.'
          br {}
          span lastLine
    else
      return false

  render: () ->
    footer {},
      @disclaimerEl()
      p
        className: 'uppercase',
          'Rogers & Goffigon LTD © 2017'
      p {},
        a
          className: 'link3',
          href: 'http://www.delanyandlong.com/',
            'For the DeLany & Long collection click here.'
      p
        span 'Site by Pentagram'
