class Push
  include Mongoid::Document

  belongs_to  :git_repository
  embeds_many :commits
end
