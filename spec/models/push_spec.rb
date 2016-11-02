require 'rails_helper'

describe Push, type: :model do
  after(:all) do
    [
      Push,
      GitRepository,
    ].each(&:destroy_all)
  end

  it 'should have commits' do
    rand_times.each do
      pm = Push.create
      cms = rand_array_of_models(:commit, push: pm)

      expect(pm.commits).to match_array(cms)
    end
  end

  it 'should reference a repo' do
    rand_array_of_models(:git_repository) do |grm|
      pm = Push.create(git_repository: grm)
      expect(pm.git_repository).to eql(grm)
      pm.reload
      expect(pm.git_repository).to eql(grm)
    end
  end
end
