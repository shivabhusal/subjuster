require "spec_helper"

RSpec.describe Subjuster::UserInput do
  it 'Should take `source_filepath` as argument while construction' do
      source_filepath = '/tmp/source_file.srt'
      expect(Subjuster::UserInput.new(source: source_filepath).source_filepath).to eq(source_filepath)
  end
  
  it 'Should take `target_filepath` as argument while construction' do
      target_filepath = '/tmp/target_file.srt.modified.srt'
      expect(Subjuster::UserInput.new(source: nil, target: target_filepath).target_filepath).to eq(target_filepath)
  end
  
  context 'should allow user to not supply target name' do
    # in overwriting case
    it 'should return source name as target when not supplied with target' do
      source_filepath = '/tmp/source_file.srt'
      target_filepath = '/tmp/source_file.srt.modified.srt'
      expect(Subjuster::UserInput.new(source: source_filepath).target_filepath).to eq(target_filepath)
    end
    
  end
  
  it 'Should take `no of seconds` to be adjusted as argument while construction' do
    expect(Subjuster::UserInput.new(source: '/', adjustment_in_sec: 12).adjustment_in_sec).to eq(12)
  end
  
  it 'Should set `no of seconds` as 0 sec if not supplied as argument while construction' do
    expect(Subjuster::UserInput.new(source: '/').adjustment_in_sec).to eq(0)
  end
  
  context 'Should be able to validate the inputs' do
    it '`source_filepath` should be valid' do
      filename = '/tmp/valid.srt'
      File.open filename, 'w'
      
      expect(Subjuster::UserInput.new(source: filename).valid?).to eq(true)
    end

    it 'should mark invalid file as invalid' do
      expect(Subjuster::UserInput.new(source: '/somerandomfile').valid?).to eq(false)
    end
  end
end

