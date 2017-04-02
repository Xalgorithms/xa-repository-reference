require 'rails_helper'

describe Api::V1::ContentController, type: :controller do
  include Randomness
  include ResponseJson

  after(:all) do
    TrialTable.destroy_all
  end
  
  it 'should show content from a trial table' do
    rand_array_of_models(:trial_table).each do |ttm|
      content = rand_array { rand_document }
      ttm.update_attributes(content: content)
    
      get(:index, trial_table_id: ttm.public_id)

      expect(response).to be_success
      expect(response_json).to eql(encode_decode(content))
    end
  end
end
