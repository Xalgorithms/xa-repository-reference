require 'rails_helper'

describe Api::V1::VersionsController, type: :controller do
  include Randomness
  include ResponseJson

  after(:all) do
    Rule.destroy_all
  end
  
  it 'should yield rules by public_id' do
    rules = rand_array_of_models(:rule)
    rules.each do |rm|
      rand_array_of_models(:version, rule: rm).each do |vm|
        get(:show, rule_id: rm.public_id, id: vm.code)

        expect(response).to be_success
        expect(response_json).to have_key('content')
        expect(response_json['content']).to eql(vm.content)
      end

      rand_array_of_hexes.each do |code|
        get(:show, rule_id: rm.public_id, id: code)

        expect(response).to_not be_success
        expect(response).to have_http_status(:not_found)
      end
    end

    rand_array_of_uuids.each do |id|
      rand_array_of_hexes.each do |code|
        get(:show, rule_id: id, id: code)

        expect(response).to_not be_success
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
