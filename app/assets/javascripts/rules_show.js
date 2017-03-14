(function () {
  function init() {
    var versions = {};

    var page_vm = _.extend({}, rule, {
      active_version: ko.observable(_.head(rule.versions)),
      versions_loaded: ko.observable(false),
      is_xalgo: ko.observable('xalgo' === rule.type),
      is_table: ko.observable('table' === rule.type)
    });

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
