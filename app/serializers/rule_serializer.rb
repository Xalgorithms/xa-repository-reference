class RuleSerializer
  def self.as_json(rule)
    {
      id: rule.public_id,
      name: rule.name,
    }
  end
end
