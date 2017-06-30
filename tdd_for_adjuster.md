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
    parsed_data = Subjuster::Parser(inputs: inputs).parse
    expect(Subjuster::Adjuster.new(data: parsed_data).data).to eq(parsed_data)
  end
```

**Output**

```Ruby
  NameError:
    uninitialized constant Subjuster::Adjuster
  # ./spec/adjuster_spec.rb:3:in `<top (required)>'
```
