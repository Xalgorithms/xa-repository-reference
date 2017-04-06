module Api
  module V1
    class StepsController < ActionController::Base
      before_filter :maybe_lookup_trial, only: [:show]
      before_filter :maybe_lookup_step, only: [:show]

      def show
        if @m
          render(json: TrialStepSerializer.as_json(@m))
        else
          render(nothing: true, status: :not_found)
        end
      end

      private

      def maybe_lookup_trial
        id = params.fetch('trial_id', nil)
        @tm = Trial.where(public_id: id).first if id
      end

      def maybe_lookup_step
        if @tm
          idx = params.fetch('id', nil).to_i
          @m = @tm.trial_steps[idx] if idx < @tm.trial_steps.count
        end
      end
    end
  end
end
