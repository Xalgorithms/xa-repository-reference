class RulesController < ApplicationController
  def index
    @rules = Rule.all.map(&RuleSerializer.method(:as_json))
    @namespaces = Namespace.all.map(&NamespaceSerializer.method(:as_json))
  end
end
