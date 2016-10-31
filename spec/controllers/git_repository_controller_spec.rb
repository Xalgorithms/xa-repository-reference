require 'rails_helper'

describe GitRepositoriesController, type: :controller do
  include Randomness

  before(:all) do
    GitRepository.destroy_all
  end
  
  it 'should assign @repositories in :index' do
    grms = rand_array_of_models(:git_repository)
    get(:index)

    expect(assigns(:repositories).to_a).to match_array(grms)
  end
end
