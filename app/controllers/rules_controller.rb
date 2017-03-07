class RulesController < ApplicationController
  def index
    @rules = RuleSerializer.many(Rule.all)
    @namespaces = Namespace.all.map(&NamespaceSerializer.method(:as_json))
    @rule_types = Rule::TYPES.map { |t| { key: t, label: I18n.t(".rule_types.#{t}", scope: 'shared') } }
  end

  def show
    @rule = RuleSerializer.as_json(Rule.where(public_id: params[:id]).first)
  end
end
