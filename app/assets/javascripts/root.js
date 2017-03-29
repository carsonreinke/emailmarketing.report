(function($) {
  $(document).ready(function() {
    $('[data-chart]').each(function() {
      var configuration = JSON.parse($(this).attr('data-chart'));
      new Chart(this, configuration);
    });
  });
})(jQuery);
