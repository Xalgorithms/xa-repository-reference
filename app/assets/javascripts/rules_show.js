(function () {
  const error_formats = {
    missing_expected_table: function (o) {
      return 'Missing expected tables: ' + _.join(o.details);
    }
  };

  function format_error_unknown(o) {
    return 'Unknown error';
  };
  
  function init() {
    function make_trial_vm(o) {
      return _.assignIn({}, o, { label: o.version + ' @ ' + o.label });
    }
    
    var versions = {};

    var page_vm = _.extend({}, rule, {
      active_version: ko.observable(_.head(rule.versions)),
      active_trial: ko.observable(_.last(rule.trials)),
      versions_loaded: ko.observable(false),
      is_xalgo: ko.observable('xalgo' === rule.type),
      is_table: ko.observable('table' === rule.type),
      trials: ko.observableArray(_.map(rule.trials, make_trial_vm)),
      results: ko.observable(),
      tabs: {
	console: {
	  active: ko.observable('errors'),
	  activate: function (k, o) {
	    page_vm.tabs.console.active(k);
	  }
	},
	xalgo: {
	  active: ko.observable('rule'),
	  activate: function (k, o) {
	    page_vm.tabs.xalgo.active(k);
	  }
	}
      }
    });

    page_vm.any_trials = ko.computed(function () {
      return _.size(page_vm.trials()) > 0;
    });

    page_vm.failures = ko.computed(function () {
      var results = page_vm.results();
      return results ? results.failures : [];
    });

    page_vm.active_trial.subscribe(function (id) {
      $.getJSON(Routes.api_v1_trial_results_path(id), function (o) {
	console.log(o);
	page_vm.results(o);
	// page_vm.active_console_tab(o.status === 'failure' ? 'errors' : 'tables');
      });
    });

    page_vm.start_trial = function () {
      var ev = {
	events_trial_add: { rule_id : rule.id, version: page_vm.active_version() }
      };
      
      send_event(ev, function (eo) {
	$.getJSON(eo.url, function (o) {
	  page_vm.trials.push(make_trial_vm(o));
	  page_vm.active_trial(o.id);
	});
      });
    };

    page_vm.activate_tables = function () {
      page_vm.active_console_tab('tables');
    };

    page_vm.activate_stack = function () {
      page_vm.active_console_tab('stack');
    };

    page_vm.activate_errors = function () {
      page_vm.active_console_tab('errors');
    };

    page_vm.activate_global_tables = function () {
      page_vm.active_xalgo_tab('tables');
    };

    page_vm.activate_rule = function () {
      page_vm.active_xalgo_tab('rule');
    };

    page_vm.format_error = function (o) {
      return _.get(error_formats, o.reason, format_error_unknown)(o);
    };

    // get all the versions
    _.each(rule.versions, function (ver) {
      $.getJSON(Routes.api_v1_rule_version_path(rule.id, ver), function (o) {
	_.set(versions, ver, o);
	page_vm.versions_loaded(_.size(versions) === _.size(rule.versions));
      });
    });

    page_vm.active_content = ko.computed(function () {
      return page_vm.versions_loaded() ? _.get(versions, page_vm.active_version()) : null;
    });
    
    ko.applyBindings(page_vm, document.getElementById('page'));
  }

  define_on_page('rules', 'show', init);
})();
