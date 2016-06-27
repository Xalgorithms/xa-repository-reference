class Rule
  include Mongoid::Document

  field :name, type: String
  field :public_id, type: String

  embeds_many :versions
end
