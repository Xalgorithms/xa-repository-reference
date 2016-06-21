class RegistriesController < ApplicationController
  def index
    @registries = Registry.all.map { |o| { id: o.id.to_s, url: o.url, our_url: o.our_url, our_public_id: o.our_public_id } }
  end
end
