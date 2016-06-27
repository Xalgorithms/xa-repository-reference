module Events
  class RegistryDestroy < Event
    field :registry_id, type: String

    after_create do |e|
      EventService.registry_destroy(e._id.to_s)
    end
  end
end
