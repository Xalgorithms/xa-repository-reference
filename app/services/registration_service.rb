class RegistrationService
  def self.register_all(rm)
    Registry.all.each { |rgm| register_all_at(rgm, rm) }
  end

  private
  
  def self.register_all_at(rgm, rm)
    Rails.logger.debug("> sending new version to registry (url=#{rgm.url})")
    cl = RegistryClient.new(rgm.url)
    rm.versions.each { |vm| register_one_at(cl, rgm, rm, vm) }
  end

  def self.register_one_at(cl, rgm, rm, vm)
    cl.create_rule(rm.namespace.name, rm.name, vm.code, rgm.registered_public_id) do |public_id|
      Rails.logger.debug("> creating registration (registry=#{rgm.public_id}; rule=#{public_id})")
      Registration.create(registry_public_id: rgm.public_id, rule_public_id: public_id, version: vm.code, rule: rm)
    end
  end
end
