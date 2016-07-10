class RuleSerializer
  def self.as_json(rule)
    {
      id: rule.public_id,
      name: rule.name,
      versions: rule.versions.map { |ver| ver.created_at.to_s(:number) },
      namespace: { name: rule.namespace.name },
    }
  end
end
