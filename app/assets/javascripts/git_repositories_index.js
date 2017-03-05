(function () {
  function init() {
    var page_vm = {
      modals: {
	add: {
	  active: ko.observable(false),
	  name: ko.observable(),
	  url: ko.observable()
	}
      }
    };

    function make_repo_vm(o) {
      var extras = {
	destroy: function () {
	  var ev = {
	    events_git_repository_destroy: {
              git_repopository_id: o.id
            }
	  };

	  send_event(ev, function (eo) {
	    page_vm.git_repositories.remove(function (ro) {
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
    page_vm.git_repositories = ko.observableArray(_.map(git_repositories, make_repo_vm));

    page_vm.modals.add.deactivate = function () {
      page_vm.modals.add.active(false);
    };
    
    page_vm.modals.add.send = function (vm) {
      var ev = {
	events_git_repository_add: {
	  name: vm.name(),
          url: vm.url()
        }
      };

      send_event(ev, function (eo) {
      	$.getJSON(eo.url, function (ro) {
      	  page_vm.git_repositories.push(make_repo_vm(ro));
      	  vm.active(false);
      	});
      });
    };

    ko.applyBindings(page_vm, document.getElementById('page'));
  }

  define_on_page('git_repositories', 'index', init);
})();
