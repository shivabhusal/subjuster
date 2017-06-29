module Subjuster
  class Parser
    attr_reader :inputs
    def initialize(inputs:)
      @inputs = inputs
    end
    
    def parse
      items = []
      file_content_array = File.read(inputs.source_filepath).split("\n")
      count = file_content_array.count
      index = 0

      while index < count do
        line = file_content_array[index]

        if line =~ /\A[-+]?[0-9]+\z/
          splitted_line = file_content_array[index+1].split(' --> ')
          
          dialog, index = find_dialog_from(list: file_content_array, index: index + 2)
          
          items << { id: line, start_time: splitted_line.first, end_time: splitted_line.last, dialog: dialog }
        end
      end

      items
    end
    
    private
      # This will find next `dialog number` embedded line and
      # return lines joined upto that line, along with the index of line of the `dialog num` 
      def find_dialog_from(list:, index:)
        buffer = []
        count = list.count
         while !(list[index]  =~ /\A[-+]?[0-9]+\z/) && index < count do
           buffer << list[index]
           index += 1
         end
         [buffer.join("\n"), index]
      end
  end
end
