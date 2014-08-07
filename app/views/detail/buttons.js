(function() {
  var Colors, React, Rulers, button, div, img, li, p, span, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, button = _ref.button, span = _ref.span, p = _ref.p, img = _ref.img, ul = _ref.ul, li = _ref.li;

  Colors = require('./related');

  Rulers = require('./ruler');

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        colorBoxView: false,
        farView: false,
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
    toggleColorBoxView: function() {
      return this.setState({
        colorBoxView: !this.state.colorBoxView
      });
    },
    handleUserInput: function(newSt) {
      return this.setState(newSt);
    },
    render: function() {
      var color_toggle_class, divs, imgClass, imgDiv, imgPath, imgSize, item, ww;
      item = this.props.model;
      ww = this.state.windowWidth;
      if (ww < 700) {
        imgSize = 'small';
      } else if (ww < 1536) {
        imgSize = 'large';
      } else {
        imgSize = 'xlarge';
      }
      if (this.state.farView) {
        imgPath = item._file[imgSize].path_far;
        imgClass = 'img-container pattern';
        imgDiv = '';
      } else {
        imgPath = item._file[imgSize].path;
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
        onClick: this.toggleColorBoxView,
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
        divs.push(Colors({
          key: 'related-colors',
          collection: this.props.collection,
          handleUserInput: this.props.handleUserInput,
          setParentState: this.handleUserInput
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
          imgSize: imgSize
        }));
      }
      return div({
        className: 'switcher'
      }, divs);
    }
  });

}).call(this);
