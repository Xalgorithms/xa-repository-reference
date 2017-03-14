module Events
  class TrialAdd < Event
    field :label,    type: String
    field :rule_id,  type: String
    
    belongs_to :trial

    after_create do |e|
      EventService.trial_add(e._id.to_s)
    end

    def initialize(*args)
      super(*args)
      self.public_id ||= UUID.generate
    end
  end
end
