module Subjuster
  class Parser
    REGEXP = /\d[\s]{,2}\Z/
    # = Parser
    #   
    #   Subjuster::Parser parses the File you provide via UserInput object
    #
    #   Example:
    #
    #     inputs = Subjuster::UserInput.new(source: 'somefilename')
    #     Subjuster::Parser.new(inputs: inputs).parse
    #
    #     # [{:id=>"1", 
    #     #  :start_time=>"00:00:57,918", 
    #     #  :end_time=>"00:01:02,514", 
    #     #  :dialog=>"\"In order to affect a timely halt\n" + "to deteriorating conditions\n"},..]
    #
    attr_reader :inputs
    def initialize(inputs:)
      @inputs = inputs
    end
    
    def parse
      inputs.validate!
      _parse
    end
    
    private
      # This will find next `dialog number` embedded line and
      # return lines joined upto that line, along with the index of line of the `dialog num` 
      def find_dialog_from(list:, index:)
        buffer = []
        count = list.count
         while !(list[index]  =~ REGEXP) && index < count do
           buffer << list[index]
           index += 1
         end
         [buffer.join("\n"), index]
      end
      
      def _parse
        items = []
        file_content_array = File.read(inputs.source_filepath).split("\n")
        count = file_content_array.count
        index = 0

        while index < count do
          line = file_content_array[index]

          if line =~ REGEXP
            splitted_line = file_content_array[index+1].split(' --> ')
            
            dialog, index = find_dialog_from(list: file_content_array, index: index + 2)
            
            items << { id: line, start_time: splitted_line.first, end_time: splitted_line.last, dialog: dialog }
          else
            index += 1
          end
        end

        items
      end
  end
end
