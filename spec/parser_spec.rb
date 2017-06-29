require "spec_helper"

RSpec.describe Subjuster::Parser do
  it 'Should take `user_input` as params' do
    inputs = Subjuster::UserInput.new(source: 'somefilename')
    expect(Subjuster::Parser.new(inputs: inputs).inputs).to equal(inputs)
  end
  
  describe 'parse()' do
    it 'Should able to parse the valid `srt` file' do
      # Mocking any request goes to `File.read`
      str_content = fixture_data
      allow(File).to receive(:read){str_content}
      
      inputs = Subjuster::UserInput.new(source: 'somefilename')
      expect(Subjuster::Parser.new(inputs: inputs).parse.first).to be_a(Hash)
    end
    
    it 'hash should have `start-time` and `end-time` of every dialog in the hash' do
        # Mocking any request goes to `File.read`
      str_content = fixture_data
      allow(File).to receive(:read){str_content}

      inputs = Subjuster::UserInput.new(source: 'somefilename')
      
      expect(Subjuster::Parser.new(inputs: inputs).parse.first[:start_time]).to eq('00:00:57,918')
      expect(Subjuster::Parser.new(inputs: inputs).parse.first[:end_time]).to eq('00:01:02,514')
      
      expect(Subjuster::Parser.new(inputs: inputs).parse.last[:start_time]).to eq('00:01:05,259')
      expect(Subjuster::Parser.new(inputs: inputs).parse.last[:end_time]).to eq('00:01:08,626')
    end
    
    it 'hash should have `dialog`' do
        # Mocking any request goes to `File.read`
      str_content = fixture_data
      allow(File).to receive(:read){str_content}
      inputs = Subjuster::UserInput.new(source: 'somefilename')
      
      expect(Subjuster::Parser.new(inputs: inputs).parse.first[:dialog]).to eq("\"In order to affect a timely halt\nto deteriorating conditions\n")
      expect(Subjuster::Parser.new(inputs: inputs).parse.last[:dialog]).to eq("a state of emergency is declared\nfor these territories")
    end
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
