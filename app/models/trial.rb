class Trial < PublicDocument
  field      :label,   type: String
  field      :version, type: String
  field      :results, type: Hash

  belongs_to :rule
  embeds_many :trial_steps
end
