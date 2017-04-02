require 'rails_helper'

describe Api::V1::TrialTablesController, type: :controller do
  include Randomness
  include ResponseJson

  after(:all) do
    TrialTable.destroy_all
  end
  
  it 'should show a model' do
    rand_array_of_models(:trial_table).each do |ttm|
      get(:show, id: ttm.public_id)

      expect(response).to be_success
      expect(response_json).to eql(encode_decode(TrialTableSerializer.as_json(ttm)))
    end

    rand_array_of_uuids.each do |id|
      get(:show, id: id)

      expect(response).to_not be_success
      expect(response).to have_http_status(:not_found)
    end
  end
end
