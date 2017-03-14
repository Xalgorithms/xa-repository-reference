module Events
  class RegistryAdd < Event
    field :url, type: String
    field :our_url, type: String
    
    belongs_to :registry
  end
end
