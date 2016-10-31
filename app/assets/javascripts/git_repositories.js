init_on_page('git_repositories', function () {
  manage_collection(vm, {
    collection: 'git_repositories',
    modals: {
      add: '#modal-add-git-repository'
    },
    actions: {
      add: '#new_events_git_repository_add'
    },
    routes: {
      item: Routes.api_v1_git_repository_path
    },
    builders: {
      destroy: function (o) {
        return { 'events_git_repository_destroy': { 'git_repository_id' : o.id } };
      }
    }
  });
});
