require 'rails_helper'
require_relative './public_model_checks'

describe Trial, type: :model do
  include PublicModelChecks
  include Randomness
  
  after(:all) do
    models = [
      Trial,
      TrialStep,
      Rule,
    ]
    destroy_many(models)
  end

  it 'has fields' do
    verify_fields_exist(:trial, [:label, :version])
  end
  
  it 'should have a public id' do
    verify_public_id(:trial)
  end

  it 'should associate with a rule' do
    verify_belongs_to(:trial, :rule)
  end

  it 'should have trial steps' do
    verify_has_many(:trial, :trial_step)
  end
end
