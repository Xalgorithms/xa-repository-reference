require 'rails_helper'

describe GitRepository, type: :model do
  after(:all) do
    GitRepository.destroy_all
  end

  it 'should have a public id' do
    grm = GitRepository.create
    expect(grm.public_id).to_not be_nil

    id = UUID.generate
    grm = GitRepository.create(public_id: id)
    expect(grm.public_id).to eql(id)
  end

  it 'should have a url' do
    grm = GitRepository.create
    expect(grm.url).to be_nil

    url = Faker::Internet.url
    grm = GitRepository.create(url: url)
    expect(grm.url).to eql(url)
  end

  it 'should have a name' do
    grm = GitRepository.create
    expect(grm.name).to be_nil

    name = Faker::Hipster.word
    grm = GitRepository.create(name: name)
    expect(grm.name).to eql(name)
  end
end
