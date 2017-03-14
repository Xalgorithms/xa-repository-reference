module Events
  class TrialAdd < Event
    field :label,    type: String
    field :rule_id,  type: String
    
    belongs_to :trial
  end
end
