require 'registry_client'

module Api
  module V1
    class RegistriesController < ActionController::Base
      def destroy
        @registry = Registry.find(params[:id])
        cl = RegistryClient.new(@registry.url)
        opid = @registry.our_public_id
        @registry.destroy
        cl.deregister(opid)
        render(json: { id: params[:id] })
      end

      def create
        @registry = Registry.create(registry_args)
        cl = RegistryClient.new(@registry.url)
        cl.register(@registry.our_url) do |public_id|
          @registry.update_attributes(our_public_id: public_id)
        end
        render(json: @registry)
      end

      private

      def registry_args
        params.require(:registry).permit(:url, :our_url)
      end
    end
  end
end
