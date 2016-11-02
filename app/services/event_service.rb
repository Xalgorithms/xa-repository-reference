require 'registry_client'

class EventService
  def self.registry_add(event_id)
    e = Events::RegistryAdd.where(id: event_id).first
    cl = RegistryClient.new(e.url)
    cl.register(e.our_url) do |id|
      e.registry = Registry.create(
        url: e.url,
        our_url: e.our_url,
        public_id: UUID.generate,
        registered_public_id: id,
      )
      e.save
    end
  end

  def self.registry_destroy(event_id)
    e = Events::RegistryDestroy.where(id: event_id).first
    registry = Registry.where(public_id: e.registry_id).first
    cl = RegistryClient.new(registry.url)
    cl.deregister(registry.registered_public_id)
    registry.destroy
  end

  def self.rule_add(event_id)
    e = Events::RuleAdd.where(id: event_id).first

    if !e.namespace_id && e.namespace_name
      Rails.logger.debug("> creating namespace (name=#{e.namespace_name})")
      ns = Namespace.find_or_create_by(name: e.namespace_name)
    else
      Rails.logger.debug("> using existing namespace (id=#{e.namespace_id})")
      ns = Namespace.where(public_id: e.namespace_id).first
    end

    Rails.logger.debug("> locating existing rule (name=#{e.name}; namespace=#{ns.id})")
    rule = Rule.where(name: e.name, namespace: ns).first
    if !rule
      Rails.logger.debug("> creating rule (name=#{e.name}; type=#{e.rule_type})")
      rule = Rule.create(name: e.name, namespace: ns, public_id: UUID.generate, rule_type: e.rule_type)
      Rails.logger.debug("created (total=#{Rule.all.count})")
    end

    Rails.logger.debug("> rules (count=#{Rule.all.count})")

    Rails.logger.debug("> creating new version")
    Version.create(src: e.src, rule: rule, code: DateTime.now.to_s(:number))

    Rails.logger.debug("> rules (count=#{Rule.all.count})")

    Rails.logger.debug("> triggering parse of new version")
    ParseService.parse_versions(e.rule_type.to_sym, rule._id.to_s)

    Rails.logger.debug("> rules (count=#{Rule.all.count})")

    # NOTE: if services become async, this should be attached to the completion of the async
    # parse processing
    RegistrationService.register_all(rule)

    Rails.logger.debug("> rules (count=#{Rule.all.count})")
    e.rule = rule
    e.save
  end

  def self.rule_destroy(event_id)
    e = Events::RuleDestroy.where(id: event_id).first
    rule = Rule.where(public_id: e.rule_id).first
    rule.registrations.each do |r|
      p [:r, r]
      registry = Registry.where(public_id: r.registry_public_id).first
      cl = RegistryClient.new(registry.url)
      cl.delete_rule(r.registry_public_id, r.rule_public_id) do
        Rails.logger.info("! deleted rule #{r.rule_public_id} on #{r.registry_public_id}")
      end
    end
    rule.destroy
  end

  def self.namespace_add(event_id)
    e = Events::NamespaceAdd.where(id: event_id).first
    ns = Namespace.create(name: e.name, public_id: UUID.generate)
    e.namespace = ns
    e.save
  end

  def self.namespace_destroy(event_id)
    e = Events::NamespaceDestroy.where(id: event_id).first
    Namespace.where(public_id: e.namespace_id).first.destroy
  end

  def self.git_repository_add(event_id)
    e = Events::GitRepositoryAdd.where(id: event_id).first
    grm = GitRepository.create(name: e.name, url: e.url)
    e.git_repository = grm
    e.save
    GitService.init(grm._id.to_s)
  end

  def self.git_repository_destroy(event_id)
    e = Events::GitRepositoryDestroy.where(id: event_id).first
    m = GitRepository.where(public_id: e.git_repository_id).first
    if m
      GitService.clean(m._id.to_s)
      m.destroy
    end
  end
end
  
