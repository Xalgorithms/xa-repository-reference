(function () {
  function init() {
    var page_vm = {
      modals: {
	add: {
	  active: ko.observable(false),
	  url: ko.observable(),
	  our_url: ko.observable()
	}
      }
    };

    function make_registry_vm(o) {
      var extras = {
	destroy: function () {
	  var ev = {
	    events_registry_destroy: { 'registry_id' : o.id }
	  };

	  send_event(ev, function (eo) {
	    page_vm.registries.remove(function (ro) {
	      return ro.id === eo.id;
	    });
	  });
	}
      };

      return _.extend({}, o, extras);
    }

    page_vm.add = function () {
      page_vm.modals.add.active(true);
    };
    page_vm.registries = ko.observableArray(_.map(registries, make_registry_vm));

    page_vm.modals.add.deactivate = function () {
      page_vm.modals.add.active(false);
    };
    
    page_vm.modals.add.send = function (vm) {
      var ev = {
	events_registry_add: { url: vm.url(), our_url: vm.our_url() }
      };

      send_event(ev, function (eo) {
	$.getJSON(eo.url, function (ro) {
	  page_vm.registries.push(make_registry_vm(ro));
	  vm.active(false);
	});
      });
    };

    ko.applyBindings(page_vm, document.getElementById('page'));
  }

  define_on_page('registries', 'index', init);
})();
