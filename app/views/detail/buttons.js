(function() {
  var React, Rulers, button, div, img, li, p, span, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, button = _ref.button, span = _ref.span, p = _ref.p, img = _ref.img, ul = _ref.ul, li = _ref.li;

  Rulers = require('./ruler');

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        colorBoxView: false,
        colorBoxPg: 0,
        farView: false,
        pageSize: 5,
        windowWidth: window.innerWidth,
        showRuler: true
      };
    },
    handleResize: function(e) {
      return this.setState({
        windowWidth: window.innerWidth
      });
    },
    componentDidMount: function() {
      return window.addEventListener('resize', this.handleResize);
    },
    componentWillUnmount: function() {
      return window.removeEventListener('resize', this.handleResize);
    },
    render: function() {
      var cdn, color_toggle_class, divs, imgClass, imgDiv, imgPath, imgSize, item, pages, ww;
      item = this.props.model;
      cdn = '//img.rg.cape.io/';
      ww = this.state.windowWidth;
      if (ww < 700) {
        imgSize = '640';
      } else if (ww < 1800) {
        imgSize = '1536';
      } else {
        imgSize = '2560';
      }
      imgPath = cdn + 'items/' + item.id + '/';
      if (this.state.farView) {
        imgPath += 'far/' + imgSize + '.jpg';
        imgClass = 'img-container pattern';
        imgDiv = '';
      } else {
        imgPath += imgSize + '.jpg';
        imgClass = 'img-container large';
        imgDiv = img({
          className: 'img-large',
          alt: item.name,
          src: imgPath
        });
      }
      divs = [];
      color_toggle_class = 'toggle-colors hidden-xs';
      if (item.far) {
        color_toggle_class += ' with-far';
      }
      divs.push(div({
        key: 'color-button',
        className: color_toggle_class
      }, button({
        className: 'uppercase'
      }, 'Colors')));
      if (item.far) {
        divs.push(div({
          key: 'far-button',
          className: 'toggle-far hidden-xs'
        }, button({
          className: 'uppercase'
        }, span({
          className: 'pattern'
        }, 'View Pattern'))));
      }
      if (this.state.colorBoxView) {
        pages = Math.ceil(this.props.collection.length / 5);
        divs.push(div({
          key: 'related-colors',
          id: 'related-colors',
          className: 'hidden-xs'
        }));
      }
      divs.push(div({
        key: 'main-image',
        className: imgPath
      }, imgDiv));
      if (this.state.showRuler && !this.state.farView) {
        divs.push(Rulers({
          key: 'rulers',
          model: item,
          cdn: cdn,
          imgSize: imgSize
        }));
      }
      return div({
        className: 'switcher'
      }, divs);
    }
  });

}).call(this);
