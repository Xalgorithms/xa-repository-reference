module Api
  module V1
    class RulesController < ActionController::Base
      def create
        @rule = Rule.create(rule_args.except(:src))

        render(json: { id: @rule.id.to_s, name: @rule.name } )
      end
      
      def destroy
        @rule = Rule.find(params[:id])
        @rule.destroy

        render(json: { id: params[:id] })
      end

      private

      def rule_args
        params.require(:rule).permit(:name, :src)
      end
    end
  end
end
