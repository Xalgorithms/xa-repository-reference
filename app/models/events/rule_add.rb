module Events
  class RuleAdd < Event
    field :name,           type: String
    field :src,            type: String
    field :namespace_id,   type: String
    field :namespace_name, type: String 
    field :rule_type,      type: String
    
    belongs_to :rule
  end
end
