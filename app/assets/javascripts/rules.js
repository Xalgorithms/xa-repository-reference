init_on_page('rules', function () {
  vm.show_rule_details = function() {
    console.log('here');
  };

  manage_collection(vm, {
    collection: 'rules',
    modals: {
      add: '#modal-add-rule'
    },
    actions: {
      add: '#new_events_rule_add'
    },
    routes: {
      item: Routes.api_v1_rule_path
    },
    builders: {
      destroy: function (o) {
        return { 'events_rule_destroy': { 'rule_id' : o.id } }
      }
    }
  });

  var form_vm = {
      namespaces: ko.observableArray(namespaces)
  };

  ko.applyBindings(form_vm, document.getElementById('modal-add-rule'));
});
