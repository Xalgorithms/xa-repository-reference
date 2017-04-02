module Events
  class TrialTableAdd < Event
    field :trial_id,  type: String
    field :name,      type: String
    field :content,   type: String
    
    belongs_to :trial_table
  end
end
