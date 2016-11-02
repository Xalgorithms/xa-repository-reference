class Version
  include Mongoid::Document

  field :content, type: Hash
  field :src,     type: String
  field :code,    type: String

  embedded_in :rule
end
