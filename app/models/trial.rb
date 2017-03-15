class Trial < PublicDocument
  field      :label,   type: String
  field      :version, type: String
  belongs_to :rule
end
