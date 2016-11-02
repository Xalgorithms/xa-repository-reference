class RuleService
  def self.create(nsm, name, src, rt, ver=nil, &bl)
    Rails.logger.debug("> creating rule (name=#{name}; type=#{rt})")
    rm = Rule.find_or_create_by(name: name, namespace: nsm, rule_type: rt)

    if rm.versions.where(code: ver).empty?
      Rails.logger.debug("> creating new version")
      Version.create(src: src, rule: rm, code: ver ? ver : DateTime.now.to_s(:number))
      
      rule_id = rm._id.to_s
      
      Rails.logger.debug("> triggering parse of new version")
      ParseService.parse_versions(rt.to_sym, rule_id)
      
      Rails.logger.debug("> registering new version")
      RegistrationService.register_all(rule_id)
    else
      Rails.logger.debug('version exists')
    end

    bl.call(rule_id) if bl
  end
end
