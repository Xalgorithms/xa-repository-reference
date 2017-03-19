module Api
  module V1
    class ResultsController < ActionController::Base
      before_filter :maybe_lookup_trial, only: [:index]

      def index
        if @m
          render(json: @m.results)
        else
          render(nothing: true, status: :not_found)
        end
      end

      private

      def maybe_lookup_trial
        id = params.fetch('trial_id', nil)
        @m = Trial.where(public_id: id).first if id
      end
    end
  end
end
