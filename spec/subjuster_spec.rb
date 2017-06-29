require "spec_helper"

RSpec.describe Subjuster do

  describe UserInput do  
    it 'Should take `source_filepath` as argument while construction'
    it 'Should take `target_filepath` as argument while construction'
    it 'Should take `no of seconds` to be adjusted as argument while construction'
    
    context 'Should be able to validate the inputs' do
      it '`source_filepath` should be valid'
      it 'should be a valid `.srt` file'
    end
  end

  describe Parser do
    it 'Should take `user_input` as params'
    it 'Should able to parse the valid `srt` file'
    
    describe 'parse()' do
      it 'Should return a `hash` of subtitle'
      it 'hash should have `start-time` and `end-time` of every dialog in the hash'
    end
  end

  describe Adjuster do
    it 'Should be able to take the `Hash` contaning srt data-structure'
    
    describe 'adjust(no_of_seconds)' do
      it 'Should return the modified version of `Hash` supplied'
      it 'Should be able to adjust the srt `Hash`'s `start-time` and `end-time` by `+2` seconds if `+2` is passed as argument'
      it 'Should not adjust the srt `Hash`'s `start-time` and `end-time` by `-2` seconds if `+2` is passed as argument'
    end
  end

  describe Generator do
    it 'Should accept `Modified Hash` as argument'
    
    describe 'generate(target_filepath)' do
      it 'Should be able to generate a valid `.srt` file to the path asked'
    end
  end
end
