init_on_page('namespaces', function () {
  manage_collection(vm, {
    collection: 'namespaces',
    modals: {
      add: '#modal-add-namespace'
    },
    actions: {
      add: '#new_events_namespace_add'
    },
    routes: {
      item: Routes.api_v1_namespace_path
    },
    builders: {
      destroy: function (o) {
        return { 'events_namespace_destroy': { 'namespace_id' : o.id } };
      }
    }
  });
});
