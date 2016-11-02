require 'rails_helper'

describe Push, type: :model do
  after(:all) do
    Push.destroy_all
  end

  it 'should have commits' do
    rand_times.each do
      pm = Push.create
      cms = rand_array_of_models(:commit, push: pm)

      expect(pm.commits).to match_array(cms)
    end
  end
end
