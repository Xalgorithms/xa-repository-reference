class TrialTable < PublicDocument
  field      :name,   type: String
  field      :content, type: Array

  belongs_to :trial
end
