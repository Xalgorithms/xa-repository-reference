class GitRepository
  include Mongoid::Document

  field :public_id, type: String
  field :url,       type: String

  def initialize(*args)
    super(*args)
    self.public_id ||= UUID.generate
  end
end
