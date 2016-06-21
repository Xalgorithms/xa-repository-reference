function only_on_page(name, fn) {
  if ($('body').data('page') === name) {
    fn();
  }
}

function init_on_page(name, fn) {
  $(document).on('ready page:load', function () {
    only_on_page(name, function() {
      fn();
    });
  });
}

function register_destroy(ob, fn) {
  $('.destroy').on('ajax:success', function (e, o) {
    ob.remove(function (it) {
      return it.id === o.id;
    });
  });
}

function manage_collection(vm, opts) {
  $(opts.actions.add).on('ajax:success', function (e, o) {
    $(opts.modals.add).modal('toggle');
    vm[opts.collection].push(o);
    register_destroy(vm[opts.collection]);
  });

  vm.any = ko.computed(function () {
    return vm[opts.collection]().length > 0;
  });

  vm.format_url = function (o) {
    return opts.path({ id: o.id });
  };

  ko.applyBindings(vm, $('#binding-point')[0]);
  register_destroy(vm[opts.collection]);
}
