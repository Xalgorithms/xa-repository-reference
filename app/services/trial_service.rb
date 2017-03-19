require 'xa/rules/context'
require 'xa/rules/interpret'

class TrialService
  class Interpreter
    include XA::Rules::Interpret
  end

  class Audit
    def will_run(name, env)
      p [:will_run, name]
    end

    def ran(name, env)
      p [:ran, name]
    end
  end

  def self.start(id)
    tm = Trial.find(id)
    vm = tm.rule.find_version(tm.version)
    rule = interpret(vm.content)
    ctx = XA::Rules::Context.new
    tables = {}
    res = ctx.execute(rule, Audit.new)
    tm.update_attributes(results: res)
  end

  def self.interpret(content)
    Interpreter.new.interpret(content)
  end
end
