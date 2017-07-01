# spec/integrations/subjuster_core_spec.rb
require "spec_helper"

FixtureFileName = "At World's End [Bluray 720p and 1080p SRT].srt"

RSpec.describe Subjuster::Core do
  it 'expected to export a file with required adustment' do
    source_file = File.expand_path("../../fixtures/#{FixtureFileName}", __FILE__)
    target_file = File.expand_path('../../../tmp/target.srt' , __FILE__)
    # original_content = "00:01:08,695 --> 00:01:11,323"
    expected_content = "00:01:10,695 --> 00:01:13,323\r\nby decree of Lord Cutler Beckett,\r\n5"
    
    Subjuster::Core.run(source: source_file, target: target_file, adjustment_in_sec: 2)
    expect(`grep "#{expected_content}" #{target_file}`).to include(expected_content)
  end
end
