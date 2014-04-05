class String
  def to_clipboard
    popen_first_arg = RUBY_VERSION > '2' ? ['pbcopy'] : 'pbcopy'
    IO::popen(popen_first_arg, 'w') { |io| io.write self.shellescape } && self
  end

  def count_instances(regex)
    scan(regex).count
  end
end

class Object
  def interesting_methods
    case self.class
    when Class
      self.public_methods.sort - Object.public_methods
    when Module
      self.public_methods.sort - Module.public_methods
    else
      self.public_methods.sort - Object.new.public_methods
    end
  end
end

if defined? ActiveRecord
  module ActiveRecord::Relation
    # emulates Array#sample
    def sample
      self.offset(rand(self.count)).first
    end
  end

  module ActiveRecord::Base
    # emulates Array#sample
    def sample
      self.offset(rand(self.count)).first
    end
  end
end

