React = require 'react'
{div, p, a, h3, button, img} = require 'reactionary'

module.exports = React.createClass

  render: ->
    console.log @props
    console.log "about page?"
    div
      className: 'about'
      div
        className: 'film_roll',
          "slideshow-y thing has to go here"
      div
        className: 'text-area',
          p
            "Rogers & Goffigon is one of the most respected designers and producers of impeccable high-quality home furnishing textiles in the world. Many of their fabrics are manufactured at family-owned European mills in existence for generations, where skilled craftspeople with an Old World attention to detail employ traditional, centuries-old techniques to create superb woven goods and trimmings."
          p
            "The Rogers & Goffigon collection uses pure natural fibers in a spectrum of textures and weights—everything from diaphanous, whisper-sheer linen, cotton, wool and silk to plush velvets and upholstery-weight fabrics. The alluring color palette draws upon rich vegetable-based shades of robin's egg blue, sea glass green and a gorgeous range of neutrals and earth tones from palest bisque to deepest sepia. Inspired by historic textiles and patterns found in nature, all of the fabrics complement one another to grace some of today’s most timeless, classical, understatedly elegant interiors."
          p
            "Principals John Flynn and James Gould established their firm in 1988, starting out with a single suitcase of hand-trimmed samples and a firm belief that artistic integrity and an insistence on quality were the cornerstones of a meaningful design business. More than two decades later, the most sought-after interior designers continue to choose Rogers & Goffigon’s exquisite fabrics for use in both residential and commercial projects, from architecturally significant homes to top museums and luxury hotels around the world. Rogers & Goffigon sell to the trade only, through a global network of representatives and US-based showrooms, their headquarters in Greenwich, CT, and their exclusive showroom in New York City’s D & D Building."


