module Events
  class NamespaceAdd < Event
    field :name, type: String

    belongs_to :namespace
  end
end
