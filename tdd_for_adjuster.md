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

### Hunting for next Spec: Example 2

```Ruby
  describe 'adjust(no_of_seconds)' do
    it 'Should return the modified version of `Hash` supplied' do
      # Stubbing File IO
      str_content = fixture_data
      allow(File).to receive(:read){str_content}
      
      inputs = Subjuster::UserInput.new(source: 'somefile', adjustment_in_sec: 2)
      parsed_data = Subjuster::Parser.new(inputs: inputs).parse
      
      modified_data = Subjuster::Adjuster.new(data: parsed_data).run
      
      expect(modified_data.first[:start_time]).to eq('00:00:59,918')
      expect(modified_data.first[:end_time]).to   eq('00:01:04,514')
    end
```

**Output**

```Ruby
  NoMethodError:
    undefined method `run' for #<Subjuster::Adjuster:0x00557cba6c2988>
  # ./spec/adjuster_spec.rb:23:in `block (3 levels) in <top (required)>'
```

Now, we define `run` method

```Ruby
  attr_reader :data

  def initialize(data:)
    @data = data
  end

  def run
    data
  end
```

**Output**
```Ruby
  expected: "00:00:59,918"
       got: "00:00:57,918"

  (compared using ==)
  # ./spec/adjuster_spec.rb:25:in `block (3 levels) in <top (required)>'
```
