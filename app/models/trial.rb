class Trial < PublicDocument
  field      :label, type: String
  belongs_to :rule
end
