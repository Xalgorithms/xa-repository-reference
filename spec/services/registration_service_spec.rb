require 'rails_helper'

describe RegistrationService do
  after(:all) do
    [
      Rule,
      Registry,
      Registration,
      Namespace,
      Version,
    ].each(&:destroy_all)
  end
  
  it 'should register all versions' do
    rm = make_rule

    public_ids = rm.versions.inject({}) do |ids, vm|
      ids.merge(vm.code => UUID.generate)
    end
    
    rgms = rand_array_of_models(:registry)
    rgms.each do |rgm|
      cl = double(:registry_client)
      expect(RegistryClient).to receive(:new).with(rgm.url).and_return(cl)
      
      rm.versions.each do |vm|
        expect(cl).to receive(:create_rule).with(rm.namespace.name, rm.name, vm.code, rgm.registered_public_id).and_yield(public_ids[vm.code])
      end
    end

    RegistrationService.register_all(rm)

    expect(rm.registrations.count).to eql(rgms.count * rm.versions.count)
    public_ids.each do |ver, public_id|
      rgms.each do |rgm|
        rtm = rm.registrations.where(registry_public_id: rgm.public_id, rule_public_id: public_id, version: ver).first
        expect(rtm).to_not be_nil
        expect(rtm.rule).to eql(rm)
      end
    end
  end

  def make_rule
    rm = create(:rule, rule_type: rand_one(Rule::TYPES))
    rand_array_of_models(:version, rule: rm)
    rm
  end
end
