class Commit
  include Mongoid::Document
  
  field :version,  type: String
  field :added,    type: Array
  field :removed,  type: Array
  field :modified, type: Array

  embedded_in :push
end
