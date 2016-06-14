$(document).on('ready page:load', function () {
  attach_action_delete();

  $('#new_registry').on('ajax:success', function (e, o) {
    $('#modal-add-registry').modal('toggle');
    vm.registries.push(o);
  });

  ko.applyBindings(vm, $('#binding-point')[0]);
});