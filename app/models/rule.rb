class Rule
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :content, type: Hash

  attr_accessor :src
end
