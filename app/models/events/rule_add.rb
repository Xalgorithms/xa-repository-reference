module Events
  class RuleAdd < Event
    field :name, type: String
    field :src, type: String
    belongs_to :rule

    after_create do |e|
      EventService.rule_add(e._id.to_s)
    end
  end
end
