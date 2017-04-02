class TrialTableSerializer
  def self.many(ttms)
    ttms.map(&method(:as_json))
  end
  
  def self.as_json(ttm)
    {
      id: ttm.public_id,
      name: ttm.name,
    }
  end
end
