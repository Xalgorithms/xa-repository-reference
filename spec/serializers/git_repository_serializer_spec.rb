require 'rails_helper'

describe GitRepositorySerializer do
  after(:each) do
    GitRepository.destroy_all
  end
  
  it 'should serialize one model' do
    rand_array_of_models(:git_repository).each do |grm|
      ex = {
        id: grm.public_id,
        url: grm.url,
        name: grm.name,
      }

      expect(GitRepositorySerializer.as_json(grm)).to eql(ex)
    end
  end

  it 'should serialize many' do
    grms = rand_array_of_models(:git_repository)
    ex = grms.map(&GitRepositorySerializer.method(:as_json))
    expect(GitRepositorySerializer.many(grms)).to match_array(ex)
  end
end
