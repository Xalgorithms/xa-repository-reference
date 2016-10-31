require 'rails_helper'

describe Api::V1::GitRepositoriesController, type: :controller do
  include Randomness
  include ResponseJson

  after(:all) do
    GitRepository.destroy_all
  end
  
  it 'should show a model' do
    rand_array_of_models(:git_repository).each do |grm|
      get(:show, id: grm.public_id)

      expect(response).to be_success
      expect(response_json).to eql(encode_decode(GitRepositorySerializer.as_json(grm)))
    end

    rand_array_of_uuids.each do |id|
      get(:show, id: id)

      expect(response).to_not be_success
      expect(response).to have_http_status(:not_found)
    end
  end
end
