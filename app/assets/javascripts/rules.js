function register_destroy() {
  $('.destroy').on('ajax:success', function (e, o) {
    vm.rules.remove(function (it) {
      return it.id === o.id;
    });
  });
}
init_on_page('rules', function () {
  $('#new_rule').on('ajax:success', function (e, o) {
    $('#modal-add-rule').modal('toggle');
    debugger;
    vm.rules.push(o);
    register_destroy();
  });

  vm.any_rules = ko.computed(function () {
    return vm.rules().length > 0;
  });

  vm.format_rule_url = function (o) {
    return Routes.api_v1_rule_path({ id: o.id });
  };

  ko.applyBindings(vm, $('#binding-point')[0]);
  register_destroy();
});
