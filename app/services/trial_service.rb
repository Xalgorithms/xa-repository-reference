class TrialService
  def self.start(id)
    tm = Trial.find(id)
  end
end
