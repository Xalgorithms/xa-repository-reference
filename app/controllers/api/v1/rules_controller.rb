module Api
  module V1
    class RulesController < ActionController::Base
      def show
        @rule = Rule.where(public_id: params[:id]).first
        render(json: RuleSerializer.as_json(@rule))
      end
    end
  end
end
