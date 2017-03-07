class Registration
  include Mongoid::Document

  field :registry_public_id, type: String
  field :version,            type: String

  embedded_in :rule
end
