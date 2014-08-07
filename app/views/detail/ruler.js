(function() {
  var React, button, div, img, li, p, span, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, button = _ref.button, span = _ref.span, p = _ref.p, img = _ref.img, ul = _ref.ul, li = _ref.li;

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        showRuler: true,
        metric: false
      };
    },
    propTypes: {
      model: React.PropTypes.object.isRequired,
      imgSize: React.PropTypes.string.isRequired,
      cdn: React.PropTypes.string.isRequired
    },
    render: function() {
      var cmClass, els, imgClass, imgPath, inchesClass, item, unit;
      item = this.props.model;
      inchesClass = 'ruler-inches';
      cmClass = 'ruler-cm';
      if (this.state.metric) {
        unit = 'cm';
        imgClass = cmClass;
        cmClass += ' active';
      } else {
        unit = 'inch';
        imgClass = inchesClass;
        inchesClass += ' active';
      }
      imgPath = this.props.cdn + 'media/ruler/' + unit + '/' + item.ruler + '-';
      imgPath += this.props.imgSize + '.png';
      els = [];
      els.push(ul({
        key: 'ruler-toggle',
        className: 'ruler-toggle'
      }, li({
        className: inchesClass
      }, button({
        className: 'uppercase'
      }, 'Inches')), li({
        className: cmClass
      }, button({
        className: 'uppercase'
      }, 'Centimeters'))));
      els.push(div({
        key: 'rulers',
        className: 'rulers'
      }, img({
        className: imgClass,
        src: imgPath,
        alt: imgClass
      })));
      return div({
        className: 'ruler-wrap hidden-xs'
      }, els);
    }
  });

}).call(this);
