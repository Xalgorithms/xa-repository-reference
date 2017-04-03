module Events
  class TrialTableRemove < Event
    field :trial_table_id,  type: String
  end
end
