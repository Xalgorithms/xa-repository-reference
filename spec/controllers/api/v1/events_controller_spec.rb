require 'rails_helper'

describe Api::V1::EventsController, type: :controller do
  include Randomness
  include ResponseJson

  before(:all) do
    Events::GitRepositoryAdd.destroy_all
  end
  
  after(:all) do
    Events::GitRepositoryAdd.destroy_all
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
end
