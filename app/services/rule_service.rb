class RuleService
  def self.create(nsm, name, src, rt, ver=nil, &bl)
    Rails.logger.debug("> creating rule (name=#{name}; type=#{rt})")
    rm = Rule.find_or_create_by(name: name, namespace: nsm, rule_type: rt)

    Rails.logger.debug("> creating new version")
    Version.create(src: src, rule: rm, code: ver ? ver : DateTime.now.to_s(:number))

    bl.call(rm._id.to_s) if bl
  end
end
