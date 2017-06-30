## TDD for Adjuster
<img src="images/parser.png" width="340" style="padding-right: 40px"> <img src="images/supplements.png" width="300">

### Write failing test
Keep in mind; must do necessary stubs and set fixture data. The fixture data should be 
very much like read data. 

#### Test Example 1

```Ruby
  it 'Should be able to take the `Hash` contaning srt data-structure' do
    # Stubbing File IO
    str_content = fixture_data
    allow(File).to receive(:read){str_content}
    
    inputs = Subjuster::UserInput.new(source: 'somefile')
    parsed_data = Subjuster::Parser.new(inputs: inputs).parse
    expect(Subjuster::Adjuster.new(data: parsed_data).data).to eq(parsed_data)
  end
```

**Output**

```Ruby
  NameError:
    uninitialized constant Subjuster::Adjuster
  # ./spec/adjuster_spec.rb:3:in `<top (required)>'
```

**Now we approach to write code just to pass this example**

```Ruby
  # lib/subjuster/adjuster.rb
  module Subjuster
    class Adjuster
    end
  end
```

We passed that error but still error prevails

```Ruby
  ArgumentError:
    wrong number of arguments (given 1, expected 0)
  # ./spec/adjuster_spec.rb:11:in `initialize'
  # ./spec/adjuster_spec.rb:11:in `new'
  # ./spec/adjuster_spec.rb:11:in `block (2 levels) in <top (required)>'
```

Lets try again,

```Ruby
  # lib/subjuster/adjuster.rb
  module Subjuster
    class Adjuster
      attr_reader :data
      def initialize(data:)
        @data = data
      end
    end
  end
```

<b style="color: green">HURRAH!</b>

Now, it passes

<span style="color: green">
Finished in 0.00596 seconds (files took 0.21119 seconds to load)<br>
4 examples, 0 failures, 3 pending
</span>

---
