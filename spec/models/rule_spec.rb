require 'rails_helper'
require_relative './public_model_checks'

describe Rule, type: :model do
  include PublicModelChecks
  
  after(:all) do
    models = [
      Rule,
      Trial,
    ]
    destroy_many(models)
  end

  it 'should have a public id' do
    verify_public_id(:rule)
  end

  it 'should have many trials' do
    verify_has_many(:rule, :trial)
  end

  it 'should have many trial tables' do
    verify_has_many(:rule, :trial_table)
  end
end
