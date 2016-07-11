class Rule
  include Mongoid::Document

  TYPES = [:table, :xalgo]
  
  field :name,      type: String
  field :public_id, type: String
  field :rule_type, type: String

  belongs_to :namespace
  embeds_many :versions
  embeds_many :registrations
end
