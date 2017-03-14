module Events
  class Event < PublicDocument
    include Mongoid::Document
    include Mongoid::Timestamps

    after_create do |e|
      EventService.send(e.class.name.demodulize.underscore, e._id.to_s)
    end
  end
end
