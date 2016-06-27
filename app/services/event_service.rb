require 'registry_client'

class EventService
  def self.registry_add(event_id)
    e = Events::RegistryAdd.where(id: event_id).first
    cl = RegistryClient.new(e.url)
    cl.register(e.our_url) do |public_id|
      e.registry = Registry.create(url: e.url, our_url: e.our_url, public_id: UUID.generate, registered_public_id: public_id)
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
    rule = Rule.create(name: e.name, public_id: UUID.generate)
    Version.create(src: e.src, rule: rule)
    ParseService.parse_versions(rule._id.to_s)
    e.rule = rule
    e.save
  end

  def self.rule_destroy(event_id)
    e = Events::RuleDestroy.where(id: event_id).first
    rule = Rule.where(public_id: e.rule_id).first
    rule.destroy
  end
end
  
