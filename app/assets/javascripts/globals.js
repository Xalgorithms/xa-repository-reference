// TODO: cloned from xa-lichen; extract a lib
var pages = { };

function define_on_page(name, action, init_fn) {
  var k = name + '_' + action;
  pages = _.set(pages, k, init_fn);
}

function init_on_page(name, action) {
  console.log('initializing: ' + name + '/' + action);
  var k = name + '_' + action;
  var init_fn = _.get(pages, k, null);
  if (init_fn) {
    console.log('init: ' + name + '/' + action);
    init_fn();
  } else {
    console.log('missing: ' + name + '/' + action);
  }
}

function send_event(ev, fn) {
  $.post(Routes.api_v1_events_path(), ev, function (resp) {
    $.getJSON(resp.url, function (eo) {
      fn(eo);
    });
  });
}
