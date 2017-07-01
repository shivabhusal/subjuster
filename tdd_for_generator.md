# TDD for Generator
First we will write failing test. This module is supposed to generate file with name supplied by
the user.

```Ruby
  it 'Should accept `Modified Hash` as argument' do
    payload = [{id: '1', start_time: '', end_time: '', dialog: ''}, {}]
    expect(Subjuster::Generator.new(payload: payload).payload).to eq(payload)
  end
```

**Output**

```Ruby
  NameError:
    uninitialized constant Subjuster::Generator
    Did you mean?  Enumerator
  # ./spec/generator_spec.rb:3:in `<top (required)>'
```

Now, we write production code

```Ruby
  # lib/subjuster/generator.rb
  module Subjuster
    class Generator
      
    end
  end
```
`require 'subjuster/generator'` in `lib/subjuster.rb`

then we get rid of that error but, got new error; which is good by the way.

```Ruby
  ArgumentError:
    wrong number of arguments (given 1, expected 0)
  # ./spec/generator_spec.rb:6:in `initialize'
  # ./spec/generator_spec.rb:6:in `new'
  # ./spec/generator_spec.rb:6:in `block (2 levels) in <top (required)>'
```

now we write production code; then

```Ruby
  module Subjuster
    class Generator
      attr_reader :payload
      
      def initialize(payload:)
        @payload = payload
      end
    end
  end
```  


**HURRAH!**

Now, it passes

```Ruby
Finished in 0.00128 seconds (files took 0.21167 seconds to load)
2 examples, 0 failures, 1 pending
```

---

Now, targeting to next examples

```Ruby
  describe '_prepare_data()' do
    it 'should prepare data to be written to the file' do
      payload = [
        {id: '1', start_time: '00:00:50,918', end_time: '00:00:55,514', dialog: 'some dialog'}, 
        {id: '2', start_time: '00:00:50,918', end_time: '00:00:55,514', dialog: 'some dialog'}, 
      ]
      expect(Subjuster::Generator.new(payload: payload).send(:_prepare_data)).to eq(expected_data)
    end
  end
```
Here, since the module is expected to write the contents to a file, and we are doing `UnitTesting` 
so I am planning to have a private method called `_prepare_data` which will return the write-ready 
data.

It fails, then I implement the production code.

```Ruby
  module Subjuster
    class Generator
      attr_reader :payload
      
      def initialize(payload:)
        @payload = payload
      end
      
      def _prepare_data
        @payload.map do |hash|
          [
            hash[:id],
            "#{hash[:start_time]} --> #{hash[:end_time]}",
            hash[:dialog]
          ].join("\n")
        end.join("\n\n") + "\n\n"
      end
    end
  end
```

**HURRAH!**

Now, it passes

```Ruby
Finished in 0.00165 seconds (files took 0.20508 seconds to load)
3 examples, 0 failures
```
