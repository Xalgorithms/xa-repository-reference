(function () {
  function init() {
    var page_vm = {
      modals: {
	add: {
	  active: ko.observable(false),
	  name: ko.observable()	  
	}
      }      
    };

    function make_namespace_vm(o) {
      var extras = {
	destroy: function () {
	  var ev = {
	    events_namespace_destroy: { 'namespace_id' : o.id }
	  };

	  send_event(ev, function (eo) {
	    page_vm.namespaces.remove(function (ro) {
	      return ro.id === eo.id;
	    });
	  });
	}
      };

      return _.extend({}, o, extras);
    }

    page_vm.namespaces = ko.observableArray(_.map(namespaces, make_namespace_vm));

    page_vm.add = function () {
      page_vm.modals.add.active(true);
    };

    page_vm.modals.add.send = function (vm) {
      var ev = {
	events_namespace_add: {
	  name: vm.name()
        }
      };      

      send_event(ev, function (eo) {
      	$.getJSON(eo.url, function (nso) {
	  page_vm.namespaces.push(make_namespace_vm(nso));
      	  vm.active(false);
      	});
      });
      
      vm.active(false);
    };

    page_vm.modals.add.deactivate = function (vm) {
      vm.active(false);
    };

    ko.applyBindings(page_vm, document.getElementById('page'));
  }

  define_on_page('namespaces', 'index', init);
})();
