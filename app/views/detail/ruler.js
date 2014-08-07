(function() {
  var React, button, div, img, li, p, span, ul, _ref;

  React = require('react');

  _ref = require('reactionary'), div = _ref.div, button = _ref.button, span = _ref.span, p = _ref.p, img = _ref.img, ul = _ref.ul, li = _ref.li;

  module.exports = React.createClass({
    getInitialState: function() {
      return {
        showRuler: true,
        unit: 'inch',
        loadedMetric: false
      };
    },
    propTypes: {
      model: React.PropTypes.object.isRequired,
      imgSize: React.PropTypes.string.isRequired
    },
    handleUnitClick: function(e) {
      var unit;
      unit = e.target.value;
      if (e.preventDefault) {
        e.preventDefault();
      }
      return this.setState({
        unit: unit
      });
    },
    loadMetricRuler: function() {
      var item, ruler_img;
      if (!this.state.loadedMetric) {
        item = this.props.model;
        ruler_img = new Image();
        ruler_img.src = item.rulerPath.cm[this.props.imgSize];
        console.log('prefetch metric ruler ' + ruler_img.src);
        return this.setState({
          loadedMetric: true
        });
      }
    },
    render: function() {
      var cmClass, els, imgClass, imgPath, inchesClass, item, unit;
      item = this.props.model;
      unit = this.state.unit;
      inchesClass = 'ruler-inches';
      cmClass = 'ruler-cm';
      if (unit === 'cm') {
        imgClass = cmClass;
        cmClass += ' active';
      } else {
        imgClass = inchesClass;
        inchesClass += ' active';
      }
      imgPath = item.rulerPath[unit][this.props.imgSize];
      els = [];
      els.push(ul({
        key: 'ruler-toggle',
        className: 'ruler-toggle'
      }, li({
        className: inchesClass
      }, button({
        type: 'button',
        value: 'inch',
        onClick: this.handleUnitClick,
        className: 'uppercase'
      }, 'Inches')), li({
        className: cmClass
      }, button({
        type: 'button',
        value: 'cm',
        onClick: this.handleUnitClick,
        onMouseOver: this.loadMetricRuler,
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
