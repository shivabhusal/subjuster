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
      grab_date_time = false
      while index < count do
      # for line in file_content_array do
        line = file_content_array[index]
        if line =~ /\A[-+]?[0-9]+\z/
          index += 1
          line = file_content_array[index]
          splitted_line = line.split(' --> ')
          
          dialog, new_index = find_dialog_from(list: file_content_array, index: index + 1)
          items << {
            id: file_content_array[index - 1],
            start_time: splitted_line.first,
            end_time: splitted_line.last,
            dialog: dialog
          }
          # require "pry"; binding.pry
          index = new_index
          
        else
          index +=1
        end
      end
      items
    end
    
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
