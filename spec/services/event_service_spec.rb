require 'rails_helper'

describe EventService do
  after(:each) do
    GitRepository.destroy_all
    Events::GitRepositoryAdd.destroy_all
  end
  
  it 'should be triggered by creating GitRepositoryAddEvent' do
    expect(GitService).to receive(:init).at_least(:once)

    rand_array_of_models(:events_git_repository_add).each do |gram|
      grm = GitRepository.where(name: gram.name, url: gram.url).first
      expect(grm).to_not be_nil
      gram.reload
      expect(gram.git_repository).to eql(grm)
    end
  end
end
