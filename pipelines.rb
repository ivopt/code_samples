module Pipelines
  # =============================================================================
  module Pipeable
    def |(other)
      Pipelines::Pipeline.new.tap do |pipeline|
        pipeline | self
        pipeline | other
      end
    end
  end

  # =============================================================================
  class Pipeline
    def initialize
      @output, @input = IO.pipe
    end

    def add callable
      l_out = @output
      n_out, n_in = IO.pipe
      @output = n_out
      Thread.new do
        callable.call(l_out, n_in)
        n_in.close
      end
      self
    end
    alias_method :|, :add

    def << data
      data = Array(data) unless data.is_a? IO
      data.each do |line|
        @input.puts line
      end
    end

    def close; @input.close; end
    alias_method :stop, :close

    def read; @output.read; end
    def each(&block); @output.each(&block); end
  end
end

# Class.class_eval{ include Pipelines::Pipeable }
Proc.class_eval{ include Pipelines::Pipeable }
