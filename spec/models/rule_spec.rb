require 'rails_helper'

describe Rule, type: :model do
  after(:all) do
    Rule.destroy_all
  end

  it 'should have a public id' do
    rm = Rule.create
    expect(rm.public_id).to_not be_nil

    id = UUID.generate
    rm = Rule.create(public_id: id)
    expect(rm.public_id).to eql(id)
  end  
end
