require 'rails_helper'

describe EventSerializer do
  after(:each) do
    GitRepository.destroy_all
    Events::GitRepositoryAdd.destroy_all
  end
  
  it 'should serialize GitRepositoryAdd' do
    rand_array_of_models(:events_git_repository_add).each do |e|
      e.reload
      ex = {
        effect: 'addition',
        url: Rails.application.routes.url_helpers.api_v1_git_repository_path(e.git_repository.public_id),
      }
      expect(EventSerializer.as_json(e)).to eql(ex)
    end
  end
  
  it 'should serialize GitRepositoryDelete' do
    rand_array_of_models(:events_git_repository_destroy).each do |e|
      ex = {
        effect: 'deletion',
        id: e.git_repository_id
      }
      expect(EventSerializer.as_json(e)).to eql(ex)
    end
  end
end
