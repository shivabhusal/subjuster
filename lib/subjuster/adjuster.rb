module Subjuster
  class Adjuster
    attr_reader :data, :inputs
    
    def initialize(data:, inputs:)
      @data   = data
      @inputs = inputs
    end
    
    def run
      # new_data = data.clone
      data.map do |paragraph|
        paragraph[:start_time] = process_on(paragraph[:start_time])
        paragraph[:end_time]   = process_on(paragraph[:end_time])
        paragraph
      end
    end
    
    private
    
    # TODO: Refactoring needed
    def process_on(date)
      _, hrs, min, sec, milli =  /(..):(..):(..),(...)/.match(date).to_a.map(&:to_i)
      timestamp_in_msec = milli + sec*1000 + min*60000 + hrs*3600000 + (inputs.adjustment_in_sec*1000).to_i
      rim = ""

      hr = timestamp_in_msec / 3600000
      rim << "%02i" % (hr.to_s) << ":" 
      
      min = timestamp_in_msec / 60000
      timestamp_in_msec -= min*60000
      rim << "%02i" % (min.to_s) << ":" 
      
      
      sec = timestamp_in_msec / 1000
      timestamp_in_msec -= sec*1000
      rim << "%02i" % (sec.to_s) << ":" 
      
      rim.slice!(-1)
      rim << "," << timestamp_in_msec.to_s << date[12..-1]
    end
  end
end
