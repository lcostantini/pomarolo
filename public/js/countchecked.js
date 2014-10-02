var countChecked = function() {
  pomodoro_id = $(this).attr('id')
  if ($(this).is(':checked')) {
    value = "1";
  } else {
    value = "-1";
  }
  $.ajax({
    type: "POST",
    url: "/pomarolo/" + pomodoro_id + "/real/" + value,
    success:function(data) {
      $('#current-pomodoro').html(data);
    }
  });
};

$( "input[name=real-check]" ).on( "click", countChecked );
