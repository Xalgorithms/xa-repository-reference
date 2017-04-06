class TrialStep
  include Mongoid::Document
  
  field :stack,  type: Array
  field :tables, type: Hash
  
  embedded_in :trial
end
