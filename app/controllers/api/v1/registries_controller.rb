require 'registry_client'

module Api
  module V1
    class RegistriesController < ActionController::Base
      def show
        @registry = Registry.where(public_id: params[:id]).first
        render(json: RegistrySerializer.as_json(@registry))
      end
    end
  end
end
