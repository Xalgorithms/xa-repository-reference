class RuleSerializer
  def self.as_json(rule)
    {
      id: rule.public_id,
      name: rule.name,
      type: rule.rule_type,
      versions: rule.versions.map { |ver| ver.code },
      namespace: { name: rule.namespace.name },
    }
  end
end
