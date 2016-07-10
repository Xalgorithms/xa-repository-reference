class NamespacesController < ApplicationController
  def index
    @namespaces = Namespace.all.map(&NamespaceSerializer.method(:as_json))
  end
end
