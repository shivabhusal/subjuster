# TDD for Subjuster::Core
## First we write failing test
We will have a class called `Subjuster::Core` as a binder to gather components together and 
act as a whole.

```Ruby
  # spec/integrations/subjuster_core_spec.rb
  require "spec_helper"

  FixtureFileName = "At World's End [Bluray 720p and 1080p SRT].srt"

  RSpec.describe Subjuster::Core do
    it 'expected to export a file with required adustment' do
      source_file = File.expand_path("../fixtures/#{FixtureFileName}", __FILE__)
      target_file = File.expand_path('../fixtures/target.srt' , __FILE__)
      
      expected_content = "00:01:08,695 --> 00:01:11,323\nby decree of Lord Cutler Beckett,"
      
      Subjuster::Core.run(source: source_file, target: 'target.srt', adjustment_in_sec: 2)
      
      expect(target_file).to have_file_content(expected_content)
    end
  end
```

Here are doing integration test, so we expect that the file we want to modify will be modified or not.

**OUTPUT**

```Ruby
  NameError:
    uninitialized constant Subjuster::Core
  # ./spec/integrations/subjuster_spec.rb:5:in `<top (required)>'
```

Then we create the necessary constant i.e. `Subjuster::Core` in `lib/subjuster.rb`,

```Ruby
  # lib/subjuster.rb
  module Subjuster
    class Core
      
    end
  end
```

**OUTPUT**

```Ruby
  NoMethodError:
    undefined method `run` for Subjuster::Core:Class
  # ./spec/integrations/subjuster_core_spec.rb:13:in `block (2 levels) in <top (required)>'
```

We add a few lines of code like:
```Ruby
  module Subjuster
    class Core
      class << self
        def run(source:, target:, adjustment_in_sec:)
          
        end
      end
    end
  end
```

**OUTPUT**
```Ruby
  Subjuster::Core
    expected to export a file with required adjustment (FAILED - 1)
```

then we write production code

```Ruby
  # lib/subjuster.rb
  module Subjuster
    class Core
      class << self
        def run(source:, target: nil, adjustment_in_sec: 0)
          
          user_input    = UserInput.new(source: source, target: target, adjustment_in_sec: adjustment_in_sec)
          parsed_data   = Parser.new(inputs: user_input).parse
          adjusted_data = Adjuster.new(data: parsed_data, inputs: user_input).run
          
          Generator.new(payload: adjusted_data, inputs: user_input).run
          
        end
      end
    end
  end
```

This also required us to implement a method called `Subjuster::Generator#run`

```Ruby
  def run
    file_content = _prepare_data
    File.write(inputs.target_filepath, file_content)
  end
```

**HURRAY**

```Ruby
Finished in 0.06818 seconds (files took 0.21218 seconds to load)
19 examples, 0 failures
```