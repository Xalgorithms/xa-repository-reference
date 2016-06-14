module Api
  module V1
    class RegistriesController < ActionController::Base
      def destroy
        @registry = Registry.find(params[:id])
        @registry.destroy
        render(json: { id: params[:id] })
      end

      def create
        @registry = Registry.create(registry_args)
        render(json: @registry)
      end

      private

      def registry_args
        params.require(:registry).permit(:url)
      end
    end
  end
end
