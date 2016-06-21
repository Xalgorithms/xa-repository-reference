class RulesController < ApplicationController
  def index
    @rules = Rule.all.map { |r| { id: r._id.to_s, name: r.name } }
  end
end
