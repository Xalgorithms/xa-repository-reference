require 'rails_helper'

describe Api::V1::EventsController, type: :controller do
  include Randomness
  include ResponseJson

  before(:all) do
    Events::GitRepositoryAdd.destroy_all
  end
  
  after(:all) do
    Events::GitRepositoryAdd.destroy_all
    Events::GitRepositoryDestroy.destroy_all
    GitRepository.destroy_all
  end
  
  it 'should accept git repository add events' do
    rand_times.map { { url: Faker::Internet.url, name: Faker::Hipster.word } }.each do |vals|
      em_id = nil
      expect(EventService).to receive(:git_repository_add) do |id|
        em_id = id
      end
      post(:create, 'events_git_repository_add' => vals)

      expect(em_id).to_not be_nil
      em = Events::GitRepositoryAdd.find(em_id)

      expect(em).to_not be_nil
      expect(em.name).to eql(vals[:name])
      expect(em.url).to eql(vals[:url])
    end
  end

  it 'should accept git repository destroy events' do
    rand_array_of_models(:git_repository).each do |grm|
      post(:create, 'events_git_repository_destroy' => { git_repository_id: grm.public_id })

      em = Events::GitRepositoryDestroy.where(git_repository_id: grm.public_id).first
      expect(em).to_not be_nil
      expect(GitRepository.where(public_id: grm.public_id).first).to be_nil
    end
  end

  it 'should show git repository add events' do
    rand_array_of_models(:events_git_repository_add).each do |gram|
      get(:show, id: gram.public_id)
      
      gram.reload
      expect(response).to be_success
      expect(response_json).to eql(encode_decode(EventSerializer.as_json(gram)))
    end
  end
end
