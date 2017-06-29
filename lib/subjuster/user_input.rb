module Subjuster
  class UserInput
    attr_reader :source_filepath, :target_filepath, :adjustment_in_sec
    def initialize(source:, target: nil, adjustment_in_sec: 0)
      @source_filepath = source
      @target_filepath = target || @source_filepath
      @adjustment_in_sec = adjustment_in_sec
    end
    
    def valid?
      File.exist?(source_filepath)
    end
  end
end
