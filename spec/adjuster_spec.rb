require "spec_helper"

RSpec.describe Subjuster::Adjuster do
  it 'Should be able to take the `Hash` contaning srt data-structure' do
    # Stubbing File IO
    str_content = fixture_data
    allow(File).to receive(:read){str_content}
    
    inputs = Subjuster::UserInput.new(source: 'somefile')
    parsed_data = Subjuster::Parser.new(inputs: inputs).parse
    expect(Subjuster::Adjuster.new(data: parsed_data, inputs: inputs).data).to eq(parsed_data)
  end
  
  describe 'adjust(no_of_seconds)' do
    it 'Should return the modified version of `Hash` supplied' do
      # Stubbing File IO
      str_content = fixture_data
      allow(File).to receive(:read){str_content}
      
      inputs = Subjuster::UserInput.new(source: 'somefile', adjustment_in_sec: 2)
      parsed_data = Subjuster::Parser.new(inputs: inputs).parse
      
      modified_data = Subjuster::Adjuster.new(data: parsed_data, inputs: inputs).run
      
      expect(modified_data.first[:start_time]).to eq('00:00:59,918')
      expect(modified_data.first[:end_time]).to   eq('00:01:04,514')
    end
    
    it "Should be able to adjust the srt `Hash`'s `start-time` and `end-time` by `+2` seconds if `+2` is passed as argument"
    it "Should not adjust the srt `Hash`'s `start-time` and `end-time` by `-2` seconds if `+2` is passed as argument"
  end
end

# **Note**: Its important to keep the alignment as it is
#  Its sensitive, I am trying to mock file content, so trying to keep
#  data just as in the +file.srt+.
def fixture_data
<<-STR
1
00:00:57,918 --> 00:01:02,514
"In order to affect a timely halt
to deteriorating conditions

2
00:01:02,589 --> 00:01:05,183
and to ensure the common good,

3
00:01:05,259 --> 00:01:08,626
a state of emergency is declared
for these territories
STR
end
