require "spec_helper"

RSpec.describe Subjuster::UserInput do
  it 'Should take `source_filepath` as argument while construction' do
      source_filepath = '/tmp/source_file.srt'
      expect(Subjuster::UserInput.new(source: source_filepath).source_filepath).to eq(source_filepath)
  end
  
  it 'Should take `target_filepath` as argument while construction'
  it 'Should take `no of seconds` to be adjusted as argument while construction'
  
  context 'Should be able to validate the inputs' do
    it '`source_filepath` should be valid'
    it 'should be a valid `.srt` file'
  end
end

