class TrialSerializer
  def self.many(tms)
    tms.map(&method(:as_json))
  end
  
  def self.as_json(tm)
    {
      id: tm.public_id,
      label: tm.label,
      version: tm.version,
    }
  end
end
