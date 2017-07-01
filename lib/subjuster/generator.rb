module Subjuster
  class Generator
    attr_reader :payload, :inputs
    
    def initialize(payload:, inputs: nil)
      @payload = payload
      @inputs  = inputs
    end
    
    def run
      file_content = _prepare_data
      File.write(inputs.target_filepath, file_content)
    end
    
    def _prepare_data
      @payload.map do |hash|
        [
          hash[:id],
          "#{hash[:start_time]} --> #{hash[:end_time]}",
          hash[:dialog]
        ].join("\n")
      end.join("\n") + "\n\r\n"
    end
  end
end
  