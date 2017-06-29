module Subjuster
  class UserInput
    attr_reader :source_filepath
    def initialize(source:)
      @source_filepath = source
    end
  end
end
