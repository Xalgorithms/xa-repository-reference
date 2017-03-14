(function () {
  function init() {
    var versions = {};

    var page_vm = _.extend({}, rule, {
      active_version: ko.observable(_.head(rule.versions)),
      active_trial: ko.observable(_.last(rule.trials)),
      versions_loaded: ko.observable(false),
      is_xalgo: ko.observable('xalgo' === rule.type),
      is_table: ko.observable('table' === rule.type),
      trials: ko.observableArray(rule.trials)
    });

    page_vm.any_trials = ko.computed(function () {
      return _.size(page_vm.trials()) > 0;
    });

    page_vm.start_trial = function () {
      var ev = {
	events_trial_add: { rule_id : rule.id }
      };
      
      send_event(ev, function (eo) {
	$.getJSON(eo.url, function (o) {
	  page_vm.trials.push(o);
	  page_vm.active_trial(o);
	});
      });
    };

    page_vm.run_trial = function () {
      console.log('TBD');
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
