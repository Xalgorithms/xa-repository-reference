module Events
  class RegistryDestroy < Event
    field :registry_id, type: String
  end
end
