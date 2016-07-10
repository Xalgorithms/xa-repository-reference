class Version
  include Mongoid::Document
  include Mongoid::Timestamps

  field :content, type: Hash
  field :src, type: String

  embedded_in :rule

  def code
    return "#{created_at.year}.#{created_at.month}.#{created_at.day}"
  end
end
