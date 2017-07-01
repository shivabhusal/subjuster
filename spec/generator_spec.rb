require "spec_helper"

RSpec.describe Subjuster::Generator do
  it 'Should accept `Modified Hash` as argument' do
    payload = [{id: '1', start_time: '', end_time: '', dialog: ''}, {}]
    expect(Subjuster::Generator.new(payload: payload).payload).to eq(payload)
  end
  
  describe '_prepare_data()' do
    it 'should prepare data to be written to the file' do
      payload = [
        {id: '1', start_time: '00:00:50,918', end_time: '00:00:55,514', dialog: 'some dialog'}, 
        {id: '2', start_time: '00:00:50,918', end_time: '00:00:55,514', dialog: 'some dialog'}, 
      ]
      expect(Subjuster::Generator.new(payload: payload).send(:_prepare_data)).to eq(expected_data)
    end
  end
  
  describe 'generate(target_filepath)' do
    it 'Should be able to generate a valid `.srt` file to the path asked' do
    end
  end
end

def expected_data
<<-STR
1
00:00:50,918 --> 00:00:55,514
some dialog

2
00:00:50,918 --> 00:00:55,514
some dialog

STR
end