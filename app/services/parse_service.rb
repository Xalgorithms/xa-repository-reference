require 'xa/rules/parse.rb'

class ParseService
  class RuleParser
    include XA::Rules::Parse
  end
  
  def self.parse_versions(rule_id)
    rule = Rule.where(id: rule_id).first
    rp = RuleParser.new
    rule.versions.each do |ver|
      ver.content = rp.parse_buffer(ver.src)
      ver.save
    end
  end
end
