class Version
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: Hash
  field :src, type: String

  embedded_in :rule
end
