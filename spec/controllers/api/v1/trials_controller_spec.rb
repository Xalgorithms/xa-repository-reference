require 'rails_helper'

describe Api::V1::TrialsController, type: :controller do
  include Randomness
  include ResponseJson

  after(:all) do
    Trial.destroy_all
  end
  
  it 'should show a model' do
    rand_array_of_models(:trial).each do |tm|
      get(:show, id: tm.public_id)

      expect(response).to be_success
      expect(response_json).to eql(encode_decode(TrialSerializer.as_json(tm)))
    end

    rand_array_of_uuids.each do |id|
      get(:show, id: id)

      expect(response).to_not be_success
      expect(response).to have_http_status(:not_found)
    end
  end
end
