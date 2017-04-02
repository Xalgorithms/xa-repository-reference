require 'rails_helper'

describe RuleSerializer do
  after(:each) do
    Rule.destroy_all
    Trial.destroy_all
    TrialTable.destroy_all
    Version.destroy_all
  end

  def make_expected(rm)
    {
      id: rm.public_id,
      name: rm.name,
      type: rm.rule_type,
      versions: rm.versions.map { |vm| vm.code },
      namespace: { name: rm.namespace.name },
      trials: TrialSerializer.many(rm.trials),
      trial_tables: TrialTableSerializer.many(rm.trial_tables),
    }
  end

  it 'should serialize' do
    rand_array_of_models(:rule).each do |rm|
      rand_array_of_models(:version, rule: rm)
      rand_array_of_models(:trial, rule: rm)
      rand_array_of_models(:trial_table, rule: rm)
      
      expect(RuleSerializer.as_json(rm)).to eql(make_expected(rm))
    end
  end

  it 'should serialize many' do
    rms = rand_array_of_models(:rule)
    rms.each { |rm| rand_array_of_models(:version, rule: rm) }
    expected = rms.map(&method(:make_expected))
    expect(RuleSerializer.many(rms)).to eql(expected)
  end
end
