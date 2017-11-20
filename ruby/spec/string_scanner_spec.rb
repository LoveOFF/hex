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

  it '#setPos' do
    s = StringScanner.new('test string')
    s.pos = 7
    expect(s.pos).to eq(7)
    expect(s.rest).to eq('ring')
  end

  it '#charPos' do
    s = StringScanner.new("abcädeföghi")
    expect(s.charpos).to eq(0)
    expect(s.scan_until(/ä/)).to eq('abcä')
    expect(s.pos).to eq(5)
    expect(s.charpos).to eq(4)
  end

  it '#charPos - debug' do
    s = StringScanner.new("ebcadefoghi")
    expect(s.charpos).to eq(0)
    expect(s.scan_until(/a/)).to eq('ebca')
    expect(s.pos).to eq(4)
    expect(s.charpos).to eq(4)
  end

  it '#pointer' do
    s = StringScanner.new('test string')
    expect(s.pos).to eq(0)
    expect(s.scan_until(/str/)).to eq('test str')
    expect(s.pos).to eq(8)
    s.terminate # pos is now end of string
    expect(s.pos).to eq(11)
  end
end
