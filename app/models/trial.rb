class Trial < PublicDocument
  field      :label,   type: String
  field      :version, type: String
  field      :results, type: Hash

  belongs_to :rule
  has_many   :trial_tables
end
