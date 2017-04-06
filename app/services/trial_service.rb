require 'xa/rules/context'
require 'xa/rules/interpret'

class TrialService
  class Interpreter
    include XA::Rules::Interpret
  end

  class Audit
    def initialize(tm)
      @tm = tm
    end
    
    def will_run(name, env)
    end

    def ran(name, env)
      TrialStep.create(trial: @tm, tables: env[:tables], stack: env[:stack])
    end
  end

  def self.start(id)
    tm = Trial.find(id)

    vm = tm.rule.find_version(tm.version)
    if vm
      rule = interpret(vm.content)
      tables = tm.rule.trial_tables.inject({}) do |o, ttm|
        o.merge(ttm.name => ttm.content)
      end

      ctx = XA::Rules::Context.new(tables)
      res = ctx.execute(rule, Audit.new(tm))
      p res
      tm.update_attributes(results: res)
    end
  end

  def self.interpret(content)
    Interpreter.new.interpret(content)
  end
end
