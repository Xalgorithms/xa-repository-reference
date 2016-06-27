init_on_page('registries', function () {
  vm.id_or_status = function (o) {
    return o.registered_public_id ? o.registered_public_id : t.registering;
  };

  manage_collection(vm, {
    collection: 'registries',
    modals: {
      add: '#modal-add-registry'
    },
    actions: {
      add: '#new_events_registry_add'
    },
    routes: {
      item: Routes.api_v1_registry_path
    },
    builders: {
      destroy: function (o) {
        return { 'events_registry_destroy': { 'registry_id' : o.id } }
      }
    }
  });
});