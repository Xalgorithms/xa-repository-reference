init_on_page('rules', function () {
  manage_collection(vm, {
    collection: 'rules',
    modals: {
      add: '#modal-add-rule'
    },
    actions: {
      add: '#new_rule'
    },
    path: Routes.api_v1_rule_path
  });
});
