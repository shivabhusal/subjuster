module Subjuster
  # = Handle User Input
  # 
  # Being a CLI tool, Subjuster is supposed to take input from +ARGV+
  # This module will get those data via arguments to the constructor method.
  #
  # === For Example:
  #
  #   inputs = UserInput.new(source: ARGV[0], target: ARGV[1], adjustment_in_sec: ARGV[2])
  #   inputs.valid? # => true / false
  #
  class UserInput
    attr_reader :source_filepath, :target_filepath, :adjustment_in_sec
    def initialize(source:, target: nil, adjustment_in_sec: 0)
      @source_filepath = source
      @target_filepath = target || @source_filepath
      @adjustment_in_sec = adjustment_in_sec
    end
    
    # Validates the source file, if it exists
    # === Valid condition
    # 
    #   inputs = UserInput.new(source: ARGV[0], target: ARGV[1], adjustment_in_sec: ARGV[2])
    #   inputs.valid? # => true 
    #
    # === Invalid condition
    # 
    #   inputs = UserInput.new(source: ARGV[0], target: ARGV[1], adjustment_in_sec: ARGV[2])
    #   inputs.valid? # => false
    #
    #
    def valid?
      File.exist?(source_filepath)
    end
  end
end
