require 'rails_helper'

describe TrialSerializer do
  after(:each) do
    Trial.destroy_all
  end

  def make_expected(tm)
    {
      id: tm.public_id,
      label: tm.label,
      version: tm.version,
    }
  end

  it 'should serialize' do
    rand_array_of_models(:trial).each do |tm|
      expect(TrialSerializer.as_json(tm)).to eql(make_expected(tm))
    end
  end

  it 'should serialize many' do
    tms = rand_array_of_models(:trial)
    expected = tms.map(&method(:make_expected))
    expect(TrialSerializer.many(tms)).to eql(expected)
  end
end
