module Events
  class TrialAdd < Event
    field :rule_id,  type: String
    
    belongs_to :trial
  end
end
