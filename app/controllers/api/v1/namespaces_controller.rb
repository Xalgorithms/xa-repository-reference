module Api
  module V1
    class NamespacesController < ActionController::Base
      def show
        @ns = Namespace.where(public_id: params[:id]).first
        render(json: NamespaceSerializer.as_json(@ns))
      end
    end
  end
end
