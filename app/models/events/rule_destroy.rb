module Events
  class RuleDestroy < Event
    field :rule_id, type: String

    after_create do |e|
      EventService.rule_destroy(e._id.to_s)
    end
  end
end
