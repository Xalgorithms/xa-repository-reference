require 'rails_helper'
require_relative './public_model_checks'

describe TrialTable, type: :model do
  include PublicModelChecks
  
  after(:all) do
    models = [
      Rule,
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

  it 'should associate with a rule' do
    verify_belongs_to(:trial_table, :rule)
  end
end
