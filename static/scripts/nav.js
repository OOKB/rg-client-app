$(document).ready(function() {
  $('.navbar-toggle').on('click touch', function() {

    var ncollapse = $('.navwrap').hasClass('collapse');
    var ncollapsing = $('.navwrap').hasClass('collapsing');
    var nin = $('.navwrap').hasClass('in');

    if (ncollapse === true) {
      $('header').addClass('active');
    } else if (ncollapsing === true) {
      $('header').addClass('active');
    } else if (nin === true) {
      $('header').removeClass('active');
    } else {
      $('header').removeClass('active');
    }

    // Navigation menu sliding for landing page
    if (ww >= 769) {
      $.when($('.landing .navwrap').hide()).then(function () {
        $('.landing header').hover(
          function() {
            if ($('.landing .navwrap').is(':visible') == false) {
              $('.landing .navwrap').slideDown();
              console.log('sliding down');
            }
          }, function() {
            if ($('.landing .navwrap').is(':visible') == true) {
              $('.landing .navwrap').slideUp();
              console.log('sliding up');
            }
          }
        );
      });
    }

  });
});
