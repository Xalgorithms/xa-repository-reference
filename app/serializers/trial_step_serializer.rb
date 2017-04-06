class TrialStepSerializer
  def self.as_json(tsm)
    {
      tables: tsm.tables,
      stack: tsm.stack,
    }
  end
end
