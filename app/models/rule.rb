class Rule < PublicDocument
  TYPES = [:table, :xalgo]
  
  field :name,      type: String
  field :rule_type, type: String

  belongs_to :namespace
  embeds_many :versions
  embeds_many :registrations
  has_many    :trials

  def find_version(code)
    versions.where(code: code).first
  end
end
