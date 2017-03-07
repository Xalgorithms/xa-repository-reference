(function () {
  var formats = {
    pull: function (o) {
      return 'PULL ' + o.namespace + ':' + o.table + ':' + o.version;
    },
    push: function (o) {
      return 'PUSH ' + o.table;
    },
    join: function (o) {
      return 'JOIN';
    },
    accumulate: function (o) {
      return 'accumulate';
    },
    commit: function (o) {
      return 'COMMIT';
    }
  };

  function format_unknown(o) {
    return 'unknown: ' + o.name;
  }
  
  this.format_xalgo = function (o) {
    return _.get(formats, o.name, format_unknown)(o);
  };
})();
