class Registry
  include Mongoid::Document

  field :public_id, type: String
  field :url, type: String
  field :registered_public_id, type: String
  field :our_url, type: String
end
