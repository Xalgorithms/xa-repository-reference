require 'rails_helper'

describe Api::V1::ResultsController, type: :controller do
  include Randomness
  include ResponseJson

  after(:all) do
    Trial.destroy_all
  end
  
  it 'should show a model' do
    rand_array_of_models(:trial).each do |tm|
      doc = rand_document
      tm.update_attributes(results: doc)
      get(:index, trial_id: tm.public_id)

      expect(response).to be_success
      expect(response_json).to eql(encode_decode(doc))
    end
  end
end
