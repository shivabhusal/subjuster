module Subjuster
  class Adjuster
    attr_reader :data
    
    def initialize(data:)
      @data = data
    end
    
    def run
      data
    end
  end
end
