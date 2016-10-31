module Api
  module V1
    class GitRepositoriesController < ActionController::Base
      before_filter :maybe_lookup_repo, only: [:show]
      
      def show
        if @m
          render(json: GitRepositorySerializer.as_json(@m))
        else
          render(nothing: true, status: :not_found)
        end
      end

      private

      def maybe_lookup_repo
        id = params.fetch('id', nil)
        @m = GitRepository.where(public_id: id).first if id
      end
    end
  end
end
