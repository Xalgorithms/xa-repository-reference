class Registry
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :url, type: String
  field :our_public_id, type: String
  field :our_url, type: String
end
