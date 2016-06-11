module Api
  module V1
    class RulesController < ActionController::Base
      def destroy
        @rule = Rule.find(params[:id])
        @rule.destroy
        render(json: { id: params[:id] })
      end
    end
  end
end
