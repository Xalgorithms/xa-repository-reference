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

      parse_rm_id = nil
      expect(ParseService).to receive(:parse_versions) do |prt, id|
        expect(prt).to eql(rt)
        parse_rm_id = id
      end

      reg_rm_id = nil
      expect(RegistrationService).to receive(:register_all) do |id|
        reg_rm_id = id
      end
      
      RuleService.create(nsm, name, src, rt, ver)

      rm = Rule.where(namespace: nsm, name: name, rule_type: rt).first
      expect(rm).to_not be_nil
      expect(parse_rm_id).to eql(rm._id.to_s)
      expect(reg_rm_id).to eql(rm._id.to_s)
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
      
      parse_rm_id = nil
      expect(ParseService).to receive(:parse_versions) do |prt, id|
        expect(prt).to eql(rt)
        parse_rm_id = id
      end

      reg_rm_id = nil
      expect(RegistrationService).to receive(:register_all) do |id|
        reg_rm_id = id
      end
      
      RuleService.create(nsm, name, src, rt, ver) do |id|
        expect(id).to eql(rm._id.to_s)
      end

      expect(Rule.where(namespace: nsm, name: name, rule_type: rt).count).to eql(1)

      rm.reload
      
      expect(rm).to_not be_nil
      expect(parse_rm_id).to eql(rm._id.to_s)
      expect(reg_rm_id).to eql(rm._id.to_s)
      expect(rm.versions.count).to eql(n_versions + 1)
      expect(rm.versions.last.src).to eql(src)
      expect(rm.versions.last.code).to_not be_nil
      expect(rm.versions.last.code).to eql(ver) if ver
    end
  end

  it 'should do nothing if the version exists' do
    rand_array_of_words.each do |name|
      nsm = create(:namespace)
      src = Faker::Lorem.sentence
      rt = rand_one(Rule::TYPES)

      rm = create(:rule, namespace: nsm, name: name, rule_type: rt)
      rand_array_of_models(:version, rule: rm)

      rm.reload
      ver = rm.versions.last.code
      n_versions = rm.versions.count
      
      expect(ParseService).to_not receive(:parse_versions)
      expect(RegistrationService).to_not receive(:register_all)
      
      expect(Rule.where(namespace: nsm, name: name, rule_type: rt).count).to eql(1)

      rm.reload
      
      expect(rm).to_not be_nil
      expect(rm.versions.count).to eql(n_versions)
    end
  end
end
