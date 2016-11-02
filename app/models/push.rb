class Push
  include Mongoid::Document

  field :name, type: String
  embeds_many :commits
end
