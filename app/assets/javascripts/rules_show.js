(function () {
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
      active_tab: ko.observable('errors')
    });

    page_vm.any_trials = ko.computed(function () {
      return _.size(page_vm.trials()) > 0;
    });


    page_vm.active_trial.subscribe(function (id) {
      $.getJSON(Routes.api_v1_trial_results_path(id), function (o) {
	page_vm.results(o);
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
      page_vm.active_tab('tables');
    };

    page_vm.activate_stack = function () {
      page_vm.active_tab('stack');
    };

    page_vm.activate_errors = function () {
      page_vm.active_tab('errors');
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
