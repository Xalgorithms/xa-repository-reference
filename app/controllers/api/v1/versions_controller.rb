require 'xa/rules/parse'

module Api
  module V1
    class VersionsController < ActionController::Base
      include XA::Rules::Parse

      def show
        rule = Rule.where(public_id: params[:rule_id]).first
        if rule
          Rails.logger.info("# located a rule (public_id=#{rule.public_id})")
          @ver = rule.versions.select { |v| v.code.to_i == params[:id].to_i }.first
          if @ver
            Rails.logger.info("# located the correct version")
            o = { content: @ver.content }
            o[:unparsed] = unparse(@ver.content['actions']) if rule.rule_type == 'xalgo' if @ver.content.any?
            render(json: o)
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
