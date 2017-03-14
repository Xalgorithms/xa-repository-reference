class EventSerializer
  EVENTS = {
    Events::RegistryAdd          => :registry_add,
    Events::RegistryDestroy      => :registry_destroy,
    Events::RuleAdd              => :rule_add,
    Events::RuleDestroy          => :rule_destroy,
    Events::NamespaceAdd         => :namespace_add,
    Events::NamespaceDestroy     => :namespace_destroy,
    Events::GitRepositoryAdd     => :git_repository_add,
    Events::GitRepositoryDestroy => :git_repository_destroy,
    Events::TrialAdd             => :trial_add,
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

  def self.namespace_add(e)
    {
      effect: 'addition',
      url: Rails.application.routes.url_helpers.api_v1_namespace_path(e.namespace.public_id),
    }
  end

  def self.namespace_destroy(e)
    {
      effect: 'deletion',
      id: e.namespace_id,
    }
  end

  def self.git_repository_add(e)
    {
      effect: 'addition',
      url: Rails.application.routes.url_helpers.api_v1_git_repository_path(e.git_repository.public_id),
    }
  end

  def self.git_repository_destroy(e)
    {
      effect: 'deletion',
      id: e.git_repository_id,
    }
  end

  def self.trial_add(e)
    {
      effect: 'addition',
      url: Rails.application.routes.url_helpers.api_v1_trial_path(e.trial.public_id),
    }      
  end
end
