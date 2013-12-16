# Extends the module object with module and instance accessors for class attributes,
# just like the native attr* accessors for instance attributes.

class Module
  # =============================================================================
  def module_attr_reader opts
    Array(opts).each do |m_name, default_value|
      class_eval(<<-RUBY, __FILE__, __LINE__)
        @@#{m_name} = default_value unless defined? @@#{m_name}
        def self.#{m_name}; @@#{m_name}; end
      RUBY
    end
  end

  # =============================================================================
  def module_attr_writer opts
    Array(opts).each do |m_name, default_value|
      class_eval(<<-RUBY, __FILE__, __LINE__)
        @@#{m_name} = default_value unless defined? @@#{m_name}
        def self.#{m_name}=(obj); @@#{m_name} = obj; end
      RUBY
    end
  end

  # =============================================================================
  def module_attr_accessor opts
    module_attr_writer opts
    module_attr_reader opts
  end
end

