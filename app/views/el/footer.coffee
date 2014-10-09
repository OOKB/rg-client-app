React = require 'react'
{footer, p, span, br} = require 'reactionary'
_ = require 'lodash'
# Footer div
module.exports = React.createClass

  disclaimerEl: ->
    unless @props.initState and @props.initState.section
      return false
    section = @props.initState.section
    disclaimerSections = ['favs', 'collection', 'summer', 'projects']
    if _.contains disclaimerSections, section
      return disclaimerEl = p {},
          span 'Images shown may vary to actual.'
          br {}
          span 'Please contact your local showroom or representative.'
          br {}
          span 'For inquiries outside represented areas contact us at: 203-532-8068'
    else
      return false

  render: () ->
    footer {},
      @disclaimerEl()
      p
        className: 'uppercase',
          'Rogers & Goffigon LTD © 2014'
      p
        span 'Site by Pentagram'
