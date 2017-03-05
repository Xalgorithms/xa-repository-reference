(function () {
  function init() {
    var page_vm = {
      modals: {
	add: {
	  active: ko.observable(false),
	  name: ko.observable(),
	  src: ko.observable(),
	  namespace_id: ko.observable(),
	  rule_type: ko.observable()
	}
      }
    };

    function make_rule_vm(o) {
      var extras = {
	destroy: function () {
	  var ev = {
	    events_rule_destroy: { 'rule_id' : o.id }
	  };

	  send_event(ev, function (eo) {
	    page_vm.rules.remove(function (ro) {
	      return ro.id === eo.id;
	    });
	  });
	},
        version_list: ko.computed(function () {
	  return _.join(o.versions, ', ');
	})
      };

      return _.extend({}, o, extras);
    }

    page_vm.add = function () {
      page_vm.modals.add.active(true);
    };
    page_vm.rules = ko.observableArray(_.map(rules, make_rule_vm));

    page_vm.modals.add.deactivate = function () {
      page_vm.modals.add.active(false);
    };
    
    page_vm.modals.add.send = function (vm) {
      var ev = {
	events_rule_add: {
	  name: vm.name(),
	  src: vm.src(),
	  namespace_id: vm.namespace_id(),
	  rule_type: vm.rule_type()
        }
      };

      send_event(ev, function (eo) {
      	$.getJSON(eo.url, function (ro) {
      	  page_vm.rules.push(make_rule_vm(ro));
      	  vm.active(false);
      	});
      });
    };

    ko.applyBindings(page_vm, document.getElementById('page'));
  }

  define_on_page('rules', 'index', init);
})();
