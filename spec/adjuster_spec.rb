require "spec_helper"

RSpec.describe Adjuster do
    it 'Should be able to take the `Hash` contaning srt data-structure'
    
    describe 'adjust(no_of_seconds)' do
      it 'Should return the modified version of `Hash` supplied'
      it "Should be able to adjust the srt `Hash`'s `start-time` and `end-time` by `+2` seconds if `+2` is passed as argument"
      it "Should not adjust the srt `Hash`'s `start-time` and `end-time` by `-2` seconds if `+2` is passed as argument"
    end
  end
end
