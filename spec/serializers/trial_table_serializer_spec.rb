require 'rails_helper'

describe TrialTableSerializer do
  after(:each) do
    TrialTable.destroy_all
  end

  def make_expected(ttm)
    {
      id: ttm.public_id,
      name: ttm.name,
    }
  end

  it 'should serialize' do
    rand_array_of_models(:trial_table).each do |ttm|
      expect(TrialTableSerializer.as_json(ttm)).to eql(make_expected(ttm))
    end
  end

  it 'should serialize many' do
    ttms = rand_array_of_models(:trial_table)
    expected = ttms.map(&method(:make_expected))
    expect(TrialTableSerializer.many(ttms)).to eql(expected)
  end
end
