module Api
  module V1
    class PushesController < ActionController::Base
      def create
        pm = Push.create(git_repository: GitRepository.where(name: params['repository']['name']).first)
        params.fetch('commits', []).each do |commit|
          Commit.create(push: pm, version: commit['id'], added: commit['added'], modified: commit['modified'], removed: commit['removed'])
        end
        GitService.update(pm._id.to_s)
        render(nothing: true)
      end
    end
  end
end
