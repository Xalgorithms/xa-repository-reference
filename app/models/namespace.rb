class Namespace
  include Mongoid::Document

  field :public_id, type: String
  field :name,      type: String
end
