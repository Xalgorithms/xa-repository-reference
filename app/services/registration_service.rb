class RegistrationService
  def self.register_all(rule_id)
    rm = Rule.find(rule_id)
    Registry.all.each { |rgm| register_all_at(rgm, rm) } if rm
  end

  private
  
  def self.register_all_at(rgm, rm)
    Rails.logger.debug("> sending new version to registry (url=#{rgm.url})")
    cl = RegistryClient.new(rgm.url)
    rm.versions.each { |vm| register_one_at(cl, rgm, rm, vm) }
  end

  def self.register_one_at(cl, rgm, rm, vm)
    cl.create_rule(rm.namespace.name, rm.name, vm.code, rm.public_id, rgm.registered_public_id) do |_|
      Rails.logger.debug("> creating registration (registry=#{rgm.public_id}; rule=(public_id=#{rm.public_id}; name=#{rm.name}))")
      Registration.create(registry_public_id: rgm.public_id, version: vm.code, rule: rm)
    end
  end
end
