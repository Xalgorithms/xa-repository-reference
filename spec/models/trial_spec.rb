require 'rails_helper'
require_relative './public_model_checks'

describe Trial, type: :model do
  include PublicModelChecks
  
  after(:all) do
    models = [
      Trial,
      Rule,
    ]
    destroy_many(models)
  end

  it 'has fields' do
    verify_fields_exist(:trial, [:label])
  end
  
  it 'should have a public id' do
    verify_public_id(:trial)
  end

  it 'should associate with a rule' do
    verify_belongs_to(:trial, :rule)
  end
end
