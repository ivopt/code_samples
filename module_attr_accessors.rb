# Extends the module object with module and instance accessors for class attributes,
# just like the native attr* accessors for instance attributes.

class Module
  # =============================================================================
  def module_attr_reader opts
    if opts.is_a? Hash
      opts.each do |(m_name, default_value)|
        class_eval(<<-RUBY, __FILE__, __LINE__)
          @@#{m_name} = default_value unless defined? @@#{m_name}
          def self.#{m_name}; @@#{m_name}; end
        RUBY
      end
    else
      classic_module_attr_reader opts
    end
  end

  def module_attr_writer opts
    if opts.is_a? Hash
      opts.each do |(m_name, default_value)|
        class_eval(<<-RUBY, __FILE__, __LINE__)
          @@#{m_name} = default_value unless defined? @@#{m_name}
          def self.#{m_name}=(obj); @@#{m_name} = obj; end
        RUBY
      end
    else
      classic_module_attr_writer opts
    end
  end

  def module_attr_accessor opts
    if opts.is_a? Hash
      module_attr_writer opts
      module_attr_reader opts
    else # opts.is_a? Array or String or Symbol..
      classic_module_attr_accessor *opts
    end
  end

  # =============================================================================
  private
    def classic_module_attr_reader(*syms)
      syms.each do |sym|
        class_eval(<<-RUBY, __FILE__, __LINE__)
          @@#{sym} = nil unless defined? @@#{sym}
          def self.#{sym}; @@#{sym}; end
        RUBY
      end
    end

    def classic_module_attr_writer(*syms)
      syms.each do |sym|
        class_eval(<<-RUBY, __FILE__, __LINE__)
          @@#{sym} = nil unless defined? @@#{sym}
          def self.#{sym}=(obj); @@#{sym} = obj; end
        RUBY
      end
    end

    def classic_module_attr_accessor(*syms)
      classic_mattr_reader(*syms)
      classic_mattr_writer(*syms)
    end

end

