$(document).on('turbolinks:load', function() {
  // Ajax:before
  $('.js-form-ajax').on('ajax:before', function() {
    $('.ajax-replace-field').html('<div class="ajax-loading"></div>');
  });

  // ページ内リンクのスクロール
  $('a[href^="#"]').on('click', function() {
    var offsetY = -10;
    var time = 500;

    var target = $(this.hash);
    if (!target.length) return;

    var targetY = target.offset().top + offsetY;
    $('html, body').animate({scrollTop: targetY}, time, 'swing');
    window.history.pushState(null, null, this.hash);
    return false;
  });
});