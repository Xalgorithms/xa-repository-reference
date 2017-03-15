module Events
  class TrialAdd < Event
    field :rule_id,  type: String
    field :version,  type: String
    
    belongs_to :trial
  end
end
