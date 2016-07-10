class NamespaceSerializer
  def self.as_json(ns)
    {
      id:   ns.public_id,
      name: ns.name,
    }
  end
end
