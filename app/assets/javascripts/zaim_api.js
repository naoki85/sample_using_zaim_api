$(document).on('turbolinks:load', function() {
  $("#select-start-date").on("change", function () {
    $('.ajax-replace-field').html('<div class="ajax-loading"></div>');
    var start_date = $('option:selected').val();
    $.ajax({
      type: 'GET',
      url: '/zaim/money',
      data: {
        'start_date': start_date
      }
    });
  });
});