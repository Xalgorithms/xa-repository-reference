class Rule
  include Mongoid::Document

  field :name, type: String
  field :public_id, type: String

  belongs_to :namespace
  embeds_many :versions
  embeds_many :registrations
end
