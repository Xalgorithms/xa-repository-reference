init_on_page('registries', function () {
  vm.id_or_status = function (o) {
    return o.our_public_id ? o.our_public_id : t.registering;
  };

  manage_collection(vm, {
    collection: 'registries',
    modals: {
      add: '#modal-add-registry'
    },
    actions: {
      add: '#new_registry'
    },
    path: Routes.api_v1_registry_path
  });
});