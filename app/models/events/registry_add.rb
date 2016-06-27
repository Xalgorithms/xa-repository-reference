module Events
  class RegistryAdd < Event
    field :url, type: String
    field :our_url, type: String
    belongs_to :registry

    after_create do |e|
      EventService.registry_add(e._id.to_s)
    end
  end
end
