module RulesHelper
  def xalgo_tabs
    [
      { name: 'Rule', key: 'rule' },
      { name: 'Tables', key: 'tables' },
    ]
  end

  def console_tabs
    [
      { name: 'Tables', key: 'tables' },
      { name: 'Stack', key: 'stack' },
      { name: 'Errors', key: 'errors' },
    ]
  end
end
