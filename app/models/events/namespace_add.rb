module Events
  class NamespaceAdd < Event
    field :name, type: String

    belongs_to :namespace
    
    after_create do |e|
      EventService.namespace_add(e._id.to_s)
    end
  end
end
