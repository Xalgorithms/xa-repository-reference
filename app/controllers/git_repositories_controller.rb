class GitRepositoriesController < ApplicationController
  def index
    @repositories = GitRepository.all
  end
end
