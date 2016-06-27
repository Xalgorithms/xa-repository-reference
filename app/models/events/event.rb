module Events
  class Event
    include Mongoid::Document
    include Mongoid::Timestamps

    field :public_id, type: String
  end
end
