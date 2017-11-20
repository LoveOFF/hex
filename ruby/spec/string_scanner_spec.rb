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
    s = StringScanner.new('abcädeföghi')
    expect(s.charpos).to eq(0)
    expect(s.scan_until(/ä/)).to eq('abcä')
    expect(s.pos).to eq(5)
    expect(s.charpos).to eq(4)
  end

  it '#charPos - debug' do
    s = StringScanner.new('ebcadefoghi')
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
    s = StringScanner.new('Fri Dec 12 1975 14:39')
    expect(s.check(/Fri/)).to eq('Fri')
    expect(s.pos).to eq(0)
    expect(s.matched).to eq('Fri')
    expect(s.check(/12/)).to eq(nil)
    expect(s.matched).to eq(nil)
  end

  it '#scan_until' do
    s = StringScanner.new('Fri Dec 12 1975 14:39')
    expect(s.scan_until(/1/)).to eq('Fri Dec 1')
    expect(s.pre_match).to eq('Fri Dec ')
    expect(s.scan_until(/XYZ/)).to eq(nil)
  end

  it '#skip_until' do
    s = StringScanner.new('Fri Dec 12 1975 14:39')
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
    s = StringScanner.new('Fri Dec 12 1975 14:39')
    expect(s.check_until(/12/)).to eq('Fri Dec 12')
    expect(s.pos).to eq(0)
    expect(s.matched).to eq('12') # bug in strscan.c -- 12 is a number when it should be a string.
  end

  it '#getch' do
    s = StringScanner.new('ab')
    expect(s.getch).to eq('a')
    expect(s.getch).to eq('b')
    expect(s.getch).to eq(nil)

    s = StringScanner.new("\244\242")
    # strscan.c s.getch # => '\244\242' doesn't work on Ruby 2.3
    # instead the characters are returned one at a time.
    # probably another bug in the example.
    expect(s.getch).to eq("\xA4")
    expect(s.getch).to eq("\xA2")
    expect(s.getch).to eq(nil)
  end

  it '#get_byte' do
    s = StringScanner.new('ab')
    expect(s.get_byte).to eq('a')
    expect(s.get_byte).to eq('b')
    expect(s.get_byte).to eq(nil)

    s = StringScanner.new("\244\242")
    expect(s.get_byte).to eq("\xA4")
    expect(s.get_byte).to eq("\xA2")
    expect(s.get_byte).to eq(nil)
  end

  it '#peek' do
    s = StringScanner.new('test string')
    expect(s.peek(7)).to eq('test st')
    expect(s.peek(7)).to eq('test st')
  end

  it '#unscan' do
    s = StringScanner.new('test string')
    expect(s.scan(/\w+/)).to eq('test')
    s.unscan
    expect(s.scan(/../)).to eq('te')
    expect(s.scan(/\d/)).to eq(nil)
    expect {s.unscan}.to raise_error(StringScanner::Error) # ScanError: unscan failed: previous match record not exist
  end

  it '#bol' do
    s = StringScanner.new("test\ntest\n")
    expect(s.bol?).to eq(true)
    s.scan(/te/)
    expect(s.bol?).to eq(false)
    s.scan(/st\n/)
    expect(s.bol?).to eq(true)
    s.terminate
    expect(s.bol?).to eq(true)
  end

  it '#beginning_of_line' do
    s = StringScanner.new("test\ntest\n")
    expect(s.beginning_of_line?).to eq(true)
    s.scan(/te/)
    expect(s.beginning_of_line?).to eq(false)
    s.scan(/st\n/)
    expect(s.beginning_of_line?).to eq(true)
    s.terminate
    expect(s.beginning_of_line?).to eq(true)
  end

  it '#eos' do
    s = StringScanner.new('test string')
    expect(s.eos?).to eq(false)
    s.scan(/test/)
    expect(s.eos?).to eq(false)
    s.terminate
    expect(s.eos?).to eq(true)
  end

  it '#matchedBoolean' do
    s = StringScanner.new('test string')
    expect(s.match?(/\w+/)).to eq(4)
    expect(s.matched?).to eq(true)
    expect(s.match?(/\d+/)).to eq(nil)
    expect(s.matched?).to eq(false)
  end

  it '#matched' do
    s = StringScanner.new('test string')
    expect(s.match?(/\w+/)).to eq(4)
    expect(s.matched).to eq('test')
  end

  it '#matched_size' do
    s = StringScanner.new('test string')
    expect(s.check(/\w+/)).to eq('test')
    expect(s.matched_size).to eq(4)
    expect(s.check(/\d+/)).to eq(nil)
    expect(s.matched_size).to eq(nil)
  end

  it '#nthSubgroup' do
    s = StringScanner.new('Fri Dec 12 1975 14:39')
    expect(s.scan(/(\w+) (\w+) (\d+) /)).to eq('Fri Dec 12 ')
    expect(s[0]).to eq('Fri Dec 12 ')
    expect(s[1]).to eq('Fri')
    expect(s[2]).to eq('Dec')
    expect(s[3]).to eq('12')
    expect(s.post_match).to eq('1975 14:39')
    expect(s.pre_match).to eq('')

    s.reset
    expect(s.scan(/(?<wday>\w+) (?<month>\w+) (?<day>\d+) /)).to eq('Fri Dec 12 ')
    expect(s[0]).to eq('Fri Dec 12 ')
    expect(s[1]).to eq('Fri')
    expect(s[2]).to eq('Dec')
    expect(s[3]).to eq('12')
    expect(s[:wday]).to eq('Fri')
    expect(s[:month]).to eq('Dec')
    expect(s[:day]).to eq('12')
    expect(s.post_match).to eq('1975 14:39')
    expect(s.pre_match).to eq('')
  end

  it '#pre_match' do
    s = StringScanner.new('test string')
    expect(s.scan(/\w+/)).to eq('test')
    expect(s.scan(/\s+/)).to eq(' ')
    expect(s.pre_match).to eq('test')
    expect(s.post_match).to eq('string')
  end

  it '#post_match' do
    s = StringScanner.new('test string')
    expect(s.scan(/\w+/)).to eq('test')
    expect(s.scan(/\s+/)).to eq(' ')
    expect(s.pre_match).to eq('test')
    expect(s.post_match).to eq('string')
  end

  it '#inspect' do
    s = StringScanner.new('Fri Dec 12 1975 14:39')
    expect(s.inspect).to eq('#<StringScanner 0/21 @ "Fri D...">')
    expect(s.scan_until(/12/)).to eq('Fri Dec 12')
    expect(s.inspect).to eq('#<StringScanner 10/21 "...ec 12" @ " 1975...">')
  end
end
