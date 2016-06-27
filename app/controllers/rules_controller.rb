class RulesController < ApplicationController
  def index
    @rules = Rule.all.map(&RuleSerializer.method(:as_json))
  end
end
