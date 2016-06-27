class EventSerializer
  EVENTS = {
    Events::RegistryAdd     => :registry_add,
    Events::RegistryDestroy => :registry_destroy,
    Events::RuleAdd         => :rule_add,
    Events::RuleDestroy     => :rule_destroy,
  }
  
  def self.as_json(e)
    send(EVENTS[e.class], e)
  end

  private

  def self.registry_add(e)
    {
      effect: 'addition',
      url: Rails.application.routes.url_helpers.api_v1_registry_path(e.registry.public_id),
    }
  end

  def self.registry_destroy(e)
    {
      effect: 'deletion',
      id: e.registry_id,
    }
  end

  def self.rule_add(e)
    {
      effect: 'addition',
      url: Rails.application.routes.url_helpers.api_v1_rule_path(e.rule.public_id),
    }
  end

  def self.rule_destroy(e)
    {
      effect: 'deletion',
      id: e.rule_id,
    }
  end
end
