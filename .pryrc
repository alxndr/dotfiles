Pry.config.prompt = [
  proc { |obj, nest_level, _| "[#{nest_level}] #{obj} » " },
  proc { |obj, nest_level, _| "[#{nest_level}] #{obj} … » " }
]

if defined?(PryDebugger)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end
