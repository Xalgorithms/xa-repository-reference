class NamespaceSerializer
  def self.many(nss)
    nss.map(&method(:as_json))
  end
  
  def self.as_json(ns)
    {
      id:   ns.public_id,
      name: ns.name,
    }
  end
end
