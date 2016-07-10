module Events
  class NamespaceDestroy < Event
    field :namespace_id, type: String

    after_create do |e|
      EventService.namespace_destroy(e._id.to_s)
    end
  end
end
