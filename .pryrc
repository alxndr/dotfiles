Pry.config.prompt = [
  proc { |obj, nest_level, _| "[#{nest_level}] #{obj} » " },
  proc { |obj, nest_level, _| "[#{nest_level}] #{obj} … » " }
]
