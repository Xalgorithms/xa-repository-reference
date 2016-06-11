module Api
  module V1
    class RegistriesController < ActionController::Base
      def destroy
        @registry = Registry.find(params[:id])
        @registry.destroy
        render(json: { id: params[:id] })
      end
    end
  end
end
