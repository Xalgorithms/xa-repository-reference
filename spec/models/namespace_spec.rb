require 'rails_helper'

describe Namespace, type: :model do
  after(:all) do
    Namespace.destroy_all
  end

  it 'should have a public id' do
    nsm = Namespace.create
    expect(nsm.public_id).to_not be_nil

    id = UUID.generate
    nsm = Namespace.create(public_id: id)
    expect(nsm.public_id).to eql(id)
  end  
end
