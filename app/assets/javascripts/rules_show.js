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
    var versions = {};
    var trial_table_content = {};
    var trial_tables_loaded = ko.observable(false);

    function make_trial_vm(o) {
      return _.assignIn({}, o, { label: o.version + ' @ ' + o.label });
    }

    function get_loaded_trial_table(name) {
      return function () {
        return trial_tables_loaded() ? { loaded: true, content: _.get(trial_table_content, name) } : { loaded: false };
      };
    }

    function make_trial_table_vm(o) {
      var extras = {
        content: ko.computed(get_loaded_trial_table(o.name)),
	remove: function (vm) {
	  var ev = {
	    events_trial_table_remove: { trial_table_id: vm.id }
	  };
	  
	  send_event(ev, function (eo) {
	    page_vm.trial_tables.remove(function (o) {
	      return o.id === eo.id;
	    });
	  });
        }
      };

      extras.row_count = ko.computed(function () {
	var content = extras.content();
	return content.loaded ? _.size(content.content) : 'not loaded';
      });
      return _.assignIn({}, o, extras);
    }

    var page_vm = _.extend({}, rule, {
      active_version: ko.observable(),
      active_trial: ko.observable(),
      active_step: null,
      active_trial_tables: ko.observable({}),
      active_trial_stack: ko.observable([]),
      versions_loaded: ko.observable(false),
      is_xalgo: ko.observable('xalgo' === rule.type),
      is_table: ko.observable('table' === rule.type),
      trials: ko.observableArray(_.map(rule.trials, make_trial_vm)),
      trial_tables: ko.observableArray(_.map(rule.trial_tables, make_trial_table_vm)),
      results: ko.observable(),
      modals: {
	add_table: {
	  active: ko.observable(false),
	  name: ko.observable(),
	  content: ko.observable()
	}
      },
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

    if (_.size(rule.trials)) {
      page_vm.active_trial(_.last(rule.trials).id);
    }
    if (_.size(rule.versions)) {
      page_vm.active_version(_.head(rule.version));
    }

    page_vm.any_trials = ko.computed(function () {
      return _.size(page_vm.trials()) > 0;
    });

    page_vm.active_trial_table_names = ko.computed(function () {
      return _.keys(page_vm.active_trial_tables());
    });
    
    page_vm.failures = ko.computed(function () {
      var results = page_vm.results();
      return results ? results.failures : [];
    });

    page_vm.active_trial.subscribe(function (id) {
      $.getJSON(Routes.api_v1_trial_results_path(id), function (o) {
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

    page_vm.modals.add_table.activate = function () {
      page_vm.modals.add_table.active(true);
    };

    page_vm.modals.add_table.deactivate = function (vm) {
      vm.active(false);
    };

    page_vm.modals.add_table.send = function (vm) {
      var ev = {
	events_trial_table_add: { rule_id : rule.id, name: vm.name(), content: vm.content() || '' }
      };

      trial_tables_loaded(false);
      send_event(ev, function (eo) {
        $.getJSON(eo.url, function (o) {
	  $.getJSON(Routes.api_v1_trial_table_content_index_path(o.id), function (content) {
	    var tt = make_trial_table_vm(o);
	    trial_table_content[o.name] = content;
	    page_vm.trial_tables.push(tt);
	    trial_tables_loaded(true);
	  });
        });
      });
      vm.active(false);
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

    function make_version_vm(o) {
      var lines = _.map(o.unparsed, function (ln, i) {
	return {
	  code: ln,
	  active: ko.observable(false),
	  activate: function(vm) {
	    var id = page_vm.active_trial();
	    if (page_vm.active_step) {
	      page_vm.active_step.active(false);
	    }
	    
	    if (id) {
	      $.getJSON(Routes.api_v1_trial_step_path(id, i), function (step) {
		page_vm.active_trial_tables(_.map(step.tables, function (v, k) {
		  return { name: k, row_count: _.size(v) };
		}));
		page_vm.active_trial_stack(_.map(step.stack, function (tbl) {
		  return { row_count: _.size(tbl) };
		}));
	      });
	    }
	    vm.active(true);
	    page_vm.active_step = vm;
	  }
	};
      });

      return { lines: lines };
    };
    
    // get all the versions
    _.each(rule.versions, function (ver, i) {
      $.getJSON(Routes.api_v1_rule_version_path(rule.id, ver), function (o) {
	_.set(versions, ver, make_version_vm(o));
	page_vm.versions_loaded(_.size(versions) === _.size(rule.versions));
      });
    });

    // get all the trial tables
    _.each(rule.trial_tables, function (tt) {
      $.getJSON(Routes.api_v1_trial_table_content_index_path(tt.id), function (o) {
        _.set(trial_table_content, tt.name, o ? o : []);
        trial_tables_loaded(_.size(trial_table_content) === _.size(rule.trial_tables));
      });
    });

    page_vm.active_content = ko.computed(function () {
      return page_vm.versions_loaded() ? _.get(versions, page_vm.active_version()) : null;
    });

    ko.applyBindings(page_vm, document.getElementById('page'));
  }

  define_on_page('rules', 'show', init);
})();
