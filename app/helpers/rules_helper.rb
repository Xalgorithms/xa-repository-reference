module RulesHelper
  def format_date_as_version(dt)
    "#{dt.year}.#{dt.month}.#{dt.day}"
  end
end
