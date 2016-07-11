module Api
  module V1
    class VersionsController < ActionController::Base
      def show
        rule = Rule.elem_match(registrations: { rule_public_id: params[:rule_id] }).first
        if rule
          Rails.logger.info("# located a rule (public_id=#{rule.public_id})")
          @ver = rule.versions.select { |v| v.code == params[:id].to_i }.first
          if @ver
            Rails.logger.info("# located the correct version")
            render(json: @ver.content)
          else
            Rails.logger.error("! failed to locate the version (version=#{params[:id]})")
            render(nothing: true, status: :not_found)
          end
        else
          Rails.logger.error("! failed to locate a rule (public_id=#{params[:rule_id]})")
          render(nothing: true, status: :not_found)
        end
      end
    end
  end
end
