(function () {
  function init() {
    var page_vm = {
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

    ko.applyBindings(page_vm, document.getElementById('page'));
  }

  define_on_page('namespaces', 'index', init);
})();
