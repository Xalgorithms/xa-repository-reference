module Api
  module V1
    class PushesController < ActionController::Base
      def create
        pm = Push.create(name: params.fetch('repository', {}).fetch('name', nil))
        params.fetch('commits', []).each do |commit|
          Commit.create(push: pm, version: commit['id'], added: commit['added'], modified: commit['modified'], removed: commit['removed'])
        end
        render(nothing: true)
      end
    end
  end
end
