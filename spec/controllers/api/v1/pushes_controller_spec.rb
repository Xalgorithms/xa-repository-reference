require 'rails_helper'

describe Api::V1::PushesController, type: :controller do
  include Randomness
  include ResponseJson

  after(:all) do
    Push.destroy_all
  end

  it 'should accept pushes in github format' do
    rand_array do
      {
        'repository' => {
          'name' => Faker::Hipster.word,
        },
        'commits' => rand_array do
          {
            'id' => Faker::Number.hexadecimal(32),
            'added' => rand_array_of_file_names,
            'removed' => rand_array_of_file_names,
            'modified' => rand_array_of_file_names,
          }
        end,
      }
    end.each do |payload|
      n_pushes = Push.all.count

      post(:create, payload)

      expect(response).to be_success
      expect(Push.all.count).to eql(n_pushes + 1)

      pm = Push.last
      expect(pm.name).to eql(payload['repository']['name'])
      
      expect(pm.commits.count).to eql(payload['commits'].length)
      pm.commits.each_with_index do |cm, i|
        expect(cm.version).to eql(payload['commits'][i]['id'])
        expect(cm.added).to match_array(payload['commits'][i]['added'])
        expect(cm.removed).to match_array(payload['commits'][i]['removed'])
        expect(cm.modified).to match_array(payload['commits'][i]['modified'])
      end

      pm.destroy
    end         
  end
end
