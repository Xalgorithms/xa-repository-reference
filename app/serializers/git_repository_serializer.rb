class GitRepositorySerializer
  def self.many(grms)
    grms.map(&method(:as_json))
  end
  
  def self.as_json(grm)
    {
      id: grm.public_id,
      url: grm.url,
      name: grm.name,
    }
  end
end
