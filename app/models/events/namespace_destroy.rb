module Events
  class NamespaceDestroy < Event
    field :namespace_id, type: String
  end
end
