class RulesController < ApplicationController
  def index
    @rules = Rule.all.map(&RuleSerializer.method(:as_json))
    @namespaces = Namespace.all.map(&NamespaceSerializer.method(:as_json))
    @rule_types = Rule::TYPES.map { |t| { key: t, label: I18n.t(".rule_types.#{t}", scope: 'shared') } }
  end
end
