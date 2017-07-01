module Subjuster
  class Generator
    attr_reader :payload
    
    def initialize(payload:)
      @payload = payload
    end
    
    def _prepare_data
      @payload.map do |hash|
        [
          hash[:id],
          "#{hash[:start_time]} --> #{hash[:end_time]}",
          hash[:dialog]
        ].join("\n")
      end.join("\n\n") + "\n\n"
    end
  end
end
  