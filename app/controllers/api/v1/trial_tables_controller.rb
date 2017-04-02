module Api
  module V1
    class TrialTablesController < ActionController::Base
      before_filter :maybe_lookup, only: [:show]

      def show
        if @m
          render(json: TrialTableSerializer.as_json(@m))
        else
          render(nothing: true, status: :not_found)
        end
      end

      private

      def maybe_lookup
        id = params.fetch('id', nil)
        @m = TrialTable.where(public_id: id).first if id
      end
    end
  end
end
