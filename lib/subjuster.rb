require 'subjuster/version'
require 'subjuster/user_input'
require 'subjuster/parser'
require 'subjuster/adjuster'
require 'subjuster/generator'

# lib/subjuster.rb
module Subjuster
  class Core
    class << self
      def run(source:, target: nil, adjustment_in_sec: 0)
        user_input    = UserInput.new(source: source, target: target, adjustment_in_sec: adjustment_in_sec)
        parsed_data   = Parser.new(inputs: user_input).parse
        adjusted_data = Adjuster.new(data: parsed_data, inputs: user_input).run
        
        Generator.new(payload: adjusted_data, inputs: user_input).run
        
        $stdout.puts "Yeah! successfully adjusted and compiled to file #{user_input.target_filepath}"
        $stdout.puts 
      end
    end
  end
end
