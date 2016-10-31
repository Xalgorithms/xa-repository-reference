class GitRepositoriesController < ApplicationController
  def index
    @repositories = GitRepositorySerializer.many(GitRepository.all)
  end
end
