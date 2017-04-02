module Api
  module V1
    class ContentController < ActionController::Base
      before_filter :maybe_lookup_trial_table, only: [:index]

      def index
        if @ttm
          render(json: @ttm.content)
        else
          render(nothing: true, status: :not_found)
        end
      end

      private

      def maybe_lookup_trial_table
        id = params.fetch('trial_table_id', nil)
        @ttm = TrialTable.where(public_id: id).first if id
      end
    end
  end
end
