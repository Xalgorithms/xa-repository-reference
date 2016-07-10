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

function manage_collection(vm, opts) {
  $(opts.actions.add).on('ajax:success', function (e, o) {
    $(opts.modals.add).modal('toggle');
    $.getJSON(o.url, function (e) {
      $.getJSON(e.url, function (co) {
        vm[opts.collection].push(co);
      });
    });
  });

  vm.any = ko.computed(function () {
    return vm[opts.collection]().length > 0;
  });

  vm.format_url = function (o) {
    return opts.routes.item({ id: o.id });
  };

  vm.destroy_item = function (o) {
    $.post(Routes.api_v1_events_path(), opts.builders.destroy(o), function (resp) {
      $.getJSON(resp.url, function (e) {
        vm[opts.collection].remove(function (it) {
          return it.id == e.id;
        });
      });
    });
  };

  ko.applyBindings(vm, document.getElementById('collection'));
}
