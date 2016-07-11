require 'xa/rules/parse.rb'
require 'multi_json'

class ParseService
  def self.parse_versions(rule_type, rule_id)
    RuleParser.new.parse_rule(rule_type, Rule.where(id: rule_id).first)
  end

  class RuleParser
    include XA::Rules::Parse

    def initialize
      @parsers = {
        xalgo: method(:parse_xalgo),
        table: method(:parse_table),
      }
    end
    
    def parse_rule(rule_type, rule)
      Rails.logger.info("# parsing (type=#{rule_type}; rule=#{rule.public_id}")
      rule.versions.each do |ver|
        if !ver.content
          Rails.logger.info("# storing version (code=#{ver.code})")
          ver.content = @parsers.fetch(rule_type, method(:parse_unknown)).call(ver.src)
          ver.save
        else
          Rails.info("# already parsed")
        end
      end
    end

    private

    def parse_xalgo(src)
      parse_buffer(src)
    end

    def parse_table(src)
      { rows: MultiJson.decode(src) }
    end

    def parse_unknown(src)
      Rails.warn("# unknown parse type")
    end
  end
end
