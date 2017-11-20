require 'rspec'

describe 'StringScanner' do

  it 'parses the example string' do
    s = StringScanner.new('This is an example string')
    expect(s.eos?).to eq(false)
    expect(s.scan(/\w+/)).to eq('This')
    expect(s.scan(/\w+/)).to eq(nil)
    expect(s.scan(/\s+/)).to eq(' ')
    expect(s.scan(/\s+/)).to eq(nil)
    expect(s.scan(/\w+/)).to eq('is')
    expect(s.eos?).to eq(false)
    expect(s.scan(/\s+/)).to eq(' ')
    expect(s.scan(/\w+/)).to eq('an')
    expect(s.scan(/\s+/)).to eq(' ')
    expect(s.scan(/\w+/)).to eq('example')
    expect(s.scan(/\s+/)).to eq(' ')
    expect(s.scan(/\w+/)).to eq('string')
    expect(s.eos?).to eq(true)
    expect(s.scan(/\s+/)).to eq(nil)
    expect(s.scan(/\w+/)).to eq(nil)
  end

  it '#concat' do
    s = StringScanner.new('Fri Dec 12 1975 14:39')
    s.scan(/Fri /)
    s.concat(' +1000 GMT')

    expect(s.string).to eq('Fri Dec 12 1975 14:39 +1000 GMT')
    expect(s.scan(/Dec/)).to eq('Dec')
  end

  it '#pos' do
    s = StringScanner.new('test string')
    expect(s.pos).to eq(0)
    expect(s.scan_until(/str/)).to eq('test str')
    expect(s.pos).to eq(8)
    s.terminate # sets pos to end of str
    expect(s.pos).to eq(11)
  end
end
