function register_destroy() {
  $('.destroy').on('ajax:success', function (e, o) {
    vm.registries.remove(function (it) {
      return it._id.$oid === o.id;
    });
  });
}

$(document).on('ready page:load', function () {
  $('#new_registry').on('ajax:success', function (e, o) {
    $('#modal-add-registry').modal('toggle');
    vm.registries.push(o);
    register_destroy();
  });

  vm.any_registries = ko.computed(function () {
    return vm.registries().length > 0;
  });

  vm.format_registry_url = function (o) {
    return Routes.api_v1_registry_path({ id: o._id.$oid });
  };

  vm.id_or_status = function (o) {
    return o.our_public_id ? o.our_public_id : t.registering;
  };

  ko.applyBindings(vm, $('#binding-point')[0]);
  register_destroy();
});