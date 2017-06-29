require "spec_helper"

RSpec.describe Parser do
    it 'Should take `user_input` as params'
    it 'Should able to parse the valid `srt` file'
    
    describe 'parse()' do
      it 'Should return a `hash` of subtitle'
      it 'hash should have `start-time` and `end-time` of every dialog in the hash'
    end
  end
end
