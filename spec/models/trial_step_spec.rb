require 'rails_helper'
require_relative './public_model_checks'

describe TrialStep, type: :model do
  include PublicModelChecks
  
  after(:all) do
    models = [
      Trial,
      TrialStep,
    ]
    destroy_many(models)
  end

  it 'should associate with a rule' do
    verify_belongs_to(:trial_step, :trial)
  end
end
