function attach_action_delete() {
  $('.action-delete').on('ajax:success', function (e, o) {
    $('#card-' + o.id).remove();
  });
}