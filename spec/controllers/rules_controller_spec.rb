require 'rails_helper'

describe RulesController, type: :controller do
  include Randomness

  after(:all) do
    Rule.destroy_all
    Namespace.destroy_all
  end

  it 'should show a rule' do
    rand_array_of_models(:rule) do |rm|
      get(:show, id: rm.public_id)

      expect(assigns(:teams)).to eql(RuleSerializer.as_json(rm))
    end
  end

  it 'should list rules' do
    rms = rand_array_of_models(:rule)
    nss = rand_array_of_models(:namespace)

    get(:index)

    expect(assigns(:rules)).to eql(RuleSerializer.many(Rule.all))
    expect(assigns(:namespaces)).to eql(NamespaceSerializer.many(Namespace.all))
  end
end
