class RegistriesController < ApplicationController
  def index
    @registries = Registry.all.map(&RegistrySerializer.method(:as_json))
  end
end
