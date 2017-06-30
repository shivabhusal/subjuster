## TDD for Parser
<img src="images/parser.png" width="200"> <img src="images/supplements.png" width="200">

I am documenting here for `Parser` instead of doing in the main page, because, 
this is considered as an extra supplement. 

## Writing failing tests for the spec on the top
In the file `spec/parser_spec.rb` pick the top most example and write expectation 
in using RSpec DSL. 

See the example below. First create the class `Parser` in `/lib/subjuster/parser.rb`. Require that file in `lib/subjuster.rb` as well.

```Ruby
  # subjuster/parser.rb
  module Subjuster
    class Parser
        
    end
  end


  # spec/parser_spec.rb
  it 'Should take `user_input` as params' do
    inputs = Subjuster::UserInput.new(source: 'somefilename')
    expect(Subjuster::Parser.new(inputs: inputs).inputs).to equal(inputs)
  end
```

then you run example, you see following error
```bash
  ArgumentError:
    wrong number of arguments (given 1, expected 0)
  # ./spec/parser_spec.rb:6:in `initialize'
  # ./spec/parser_spec.rb:6:in `new'
  # ./spec/parser_spec.rb:6:in `block (2 levels) in <top (required)>'
```

then you define `constructor` and `params`, also set `attr_reader`. You are doing 
in straight forward fashion, because, you have already been through this before.

```Ruby
  module Subjuster
    class Parser
        attr_reader :inputs
        def initialize(inputs:)
          @inputs = inputs
        end
    end
  end
```

---

Now, we target for next example which is rather `complex` to test. 
```Ruby
  it 'Should able to parse the valid `srt` file'
```
Now important thing is, to test this module we need **test data** 
also called fixture data. So, you need to prepare the test data before your test-example runs.
```Ruby

def srt_content
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

```
Since we are practicing `Unit Testing` strategy, we cannot let our test-suite use FileSystem API 
to read/write to file. Therefore we created a method to return file contents.

> But Why?

Because, of the following reasons:-  
- Firstly, the content of the file will already be known to you; so no need to pretend
  to read back from FileSystem.
- File IO is very slow relative to Ruby execution. 
- Also, the philosophy of UnitTesting is to test the system in 100% isolation, if it
  touches File IO then the rules is violated.

> What would be the solution then?

You will have to assume that `File.read` always works, so you create a `stub` of the `File.read` 
method and mock in your example. We wrote the failing test like,
```Ruby
  it 'Should able to parse the valid `srt` file' do
    # Mocking any request goes to `File.read`
    str_content = fixture_data
    allow(File).to receive(:read){str_content}
    
    inputs = Subjuster::UserInput.new(source: 'somefilename')
    expect(Subjuster::Parser.new(inputs: inputs).parse.first).to be_a(Hash)
  end

```

In the example above, we mocked the behavior of `File.read` to return obvious data. This is called Monkey Patching.

When we run this example, we see the following error
```bash
  NoMethodError:
    undefined method `parse' for #<Subjuster::Parser:0x00562f71227670>

```

We will add the method `Parser#parse` and add production code and try to make it green.
Now, we have completed the code for parse to pass the test. [see the file here](lib/subjuster/parser.rb)

First, we solved the problem in any way we could, then we refactored the code to make it readable, comprehensible and if possible performant.

** Optimized code **
```Ruby
  module Subjuster
    class Parser
      attr_reader :inputs
      def initialize(inputs:)
        @inputs = inputs
      end
      
      def parse
        items = []
        file_content_array = File.read(inputs.source_filepath).split("\n")
        count = file_content_array.count
        index = 0

        while index < count do
          line = file_content_array[index]

          if line =~ /\A[-+]?[0-9]+\z/
            splitted_line = file_content_array[index+1].split(' --> ')
            
            dialog, index = find_dialog_from(list: file_content_array, index: index + 2)
            
            items << { id: line, start_time: splitted_line.first, end_time: splitted_line.last, dialog: dialog }
          end
        end

        items
      end
      
      private
        # This will find next `dialog number` embedded line and
        # return lines joined upto that line, along with the index of line of the `dialog num` 
        def find_dialog_from(list:, index:)
          buffer = []
          count = list.count
           while !(list[index]  =~ /\A[-+]?[0-9]+\z/) && index < count do
             buffer << list[index]
             index += 1
           end
           [buffer.join("\n"), index]
        end
    end
  end

```
Now, the tests passes.

**Then we pick `Subjuster::Adjuster`.**
