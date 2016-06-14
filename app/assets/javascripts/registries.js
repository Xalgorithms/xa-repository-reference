$(document).on('ready page:load', function () {
  attach_action_delete();

  $('#new_registry').on('ajax:success', function () {
    $('#modal-add-registry').modal('toggle');
  });
});