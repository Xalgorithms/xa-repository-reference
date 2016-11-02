require 'rails_helper'

describe RuleService do
  after(:all) do
    [
      Rule,
      Namespace,
      Version,
    ].each(&:destroy_all)
  end

  it 'should create new rules with a single version' do
    rand_array_of_words.each do |name|
      nsm = create(:namespace)
      src = Faker::Lorem.sentence
      rt = rand_one(Rule::TYPES)
      ver = nil

      maybe_call do
        ver = Faker::Number.number(6)
      end

      RuleService.create(nsm, name, src, rt, ver)

      rm = Rule.where(namespace: nsm, name: name, rule_type: rt).first
      expect(rm).to_not be_nil
      expect(rm.versions.count).to eql(1)
      expect(rm.versions.last.src).to eql(src)
      expect(rm.versions.last.code).to_not be_nil
      expect(rm.versions.last.code).to eql(ver) if ver
    end
  end


  it 'should add versions to an existing rule' do
    rand_array_of_words.each do |name|
      nsm = create(:namespace)
      src = Faker::Lorem.sentence
      rt = rand_one(Rule::TYPES)
      ver = nil

      maybe_call do
        ver = Faker::Number.number(6)
      end
      
      rm = create(:rule, namespace: nsm, name: name, rule_type: rt)
      rand_array_of_models(:version, rule: rm)

      rm.reload
      n_versions = rm.versions.count
      
      RuleService.create(nsm, name, src, rt, ver) do |rule_id|
        expect(rule_id).to eql(rm._id.to_s)
      end

      expect(Rule.where(namespace: nsm, name: name, rule_type: rt).count).to eql(1)

      rm.reload
      
      expect(rm).to_not be_nil
      expect(rm.versions.count).to eql(n_versions + 1)
      expect(rm.versions.last.src).to eql(src)
      expect(rm.versions.last.code).to_not be_nil
      expect(rm.versions.last.code).to eql(ver) if ver
    end
  end
end
