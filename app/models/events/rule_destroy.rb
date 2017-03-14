module Events
  class RuleDestroy < Event
    field :rule_id, type: String
  end
end
