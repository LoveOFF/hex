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

  it '#setPointer' do
    s = StringScanner.new('test string')
    s.pos = 7
    expect(s.pos).to eq(7)
    expect(s.rest).to eq('ring')
  end

  it '#scan' do
    s = StringScanner.new('test string')
    expect(s.scan(/\w+/)).to eq('test')
    expect(s.scan(/\w+/)).to eq(nil)
    expect(s.scan(/\s+/)).to eq(' ')
    expect(s.scan(/\w+/)).to eq('string')
    expect(s.scan(/./)).to eq(nil)
  end

  it '#skip' do
    s = StringScanner.new('test string')
    expect(s.skip(/\w+/)).to eq(4)
    expect(s.skip(/\w+/)).to eq(nil)
    expect(s.skip(/\s+/)).to eq(1)
    expect(s.skip(/\w+/)).to eq(6)
    expect(s.skip(/./)).to eq(nil)
  end

  it '#match' do
    s = StringScanner.new('test string')
    expect(s.match?(/\w+/)).to eq(4)
    expect(s.match?(/\w+/)).to eq(4)
    expect(s.match?(/\s+/)).to eq(nil)
  end

  it '#check' do
    s = StringScanner.new("Fri Dec 12 1975 14:39")
    expect(s.check(/Fri/)).to eq('Fri')
    expect(s.pos).to eq(0)
    expect(s.matched).to eq('Fri')
    expect(s.check(/12/)).to eq(nil)
    expect(s.matched).to eq(nil)
  end

  it '#scan_until' do
    s = StringScanner.new("Fri Dec 12 1975 14:39")
    expect(s.scan_until(/1/)).to eq('Fri Dec 1')
    expect(s.pre_match).to eq('Fri Dec ')
    expect(s.scan_until(/XYZ/)).to eq(nil)
  end

  it '#skip_until' do
    s = StringScanner.new("Fri Dec 12 1975 14:39")
    expect(s.skip_until /12/).to eq(10)
  end

  it '#exist' do
    s = StringScanner.new('test string')
    expect(s.exist?(/s/)).to eq(3)
    expect(s.scan(/test/)).to eq('test')
    expect(s.exist?(/s/)).to eq(2)
    expect(s.exist?(/e/)).to eq(nil)
  end

  it '#check_until' do
    s = StringScanner.new("Fri Dec 12 1975 14:39")
    expect(s.check_until(/12/)).to eq('Fri Dec 12')
    expect(s.pos).to eq(0)
    expect(s.matched).to eq('12') # bug in strscan.c -- 12 is a number when it should be a string.
  end
end
