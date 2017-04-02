require 'rails_helper'
require_relative './public_model_checks'

describe TrialTable, type: :model do
  include PublicModelChecks
  
  after(:all) do
    models = [
      Trial,
      TrialTable,
    ]
    destroy_many(models)
  end

  it 'has fields' do
    verify_fields_exist(:trial_table, [:name, :content])
  end
  
  it 'should have a public id' do
    verify_public_id(:trial_table)
  end

  it 'should associate with a trial' do
    verify_belongs_to(:trial_table, :trial)
  end
end
