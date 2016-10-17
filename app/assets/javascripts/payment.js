$(function($) {

  stripeResponseHandler = function (status, response) {
      var $form, token;
      $form = $(".new_payment");
      if (response.error) {
        show_error(response.error.message);
        $form.find("input[type=submit]").prop("disabled", false);
      } else {
        token = response.id;
        $form.append($("<input type=\"hidden\" name=\"payment[card_token]\" />").val(token));
        $("[data-stripe=number]").remove();
        $("[data-stripe=cvv]").remove();
        $("[data-stripe=exp-year]").remove();
        $("[data-stripe=exp-month]").remove();
        $form.get(0).submit();
      }
      return false;
  };

  show_error = function (message) {
    $("#flash-messages").html('<div class="alert alert-warning"><a class="close" data-dismiss="alert">×</a><div id="flash_alert">' + message + '</div></div>');
    $('.alert').delay(5000).fadeOut(3000);
    return false;
  };
  
  var show_error, stripeResponseHandler;
  $('.new_payment').submit( function(event) {
    var $form = $(this);

    // Disable the submit button to prevent repeated clicks
    $form.find('button').prop('disabled', true);

    Stripe.card.createToken($form, stripeResponseHandler);

    // Prevent the form from submitting with the default action
    return false;
  });

  $('#payment_tickets').change( function(event) {
    var total = $('#payment_tickets').val() * $('#new-payment-total').data('pmt-total');
    $('#new-payment-total').text('Total: $'+total);
  });
});