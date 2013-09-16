class String
  def to_clipboard
    IO::popen(%w(pbcopy), 'w') { |io| io.write self.shellescape } && self
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

