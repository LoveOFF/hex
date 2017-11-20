import  { StringScanner } from './strscan';

// it 'parses the example string' do
//     s = StringScanner.new('This is an example string')
//     expect(s.eos?).to eq(false)
//     expect(s.scan(/\w+/)).to eq('This')
//     expect(s.scan(/\w+/)).to eq(nil)
//     expect(s.scan(/\s+/)).to eq(' ')
//     expect(s.scan(/\s+/)).to eq(nil)
//     expect(s.scan(/\w+/)).to eq('is')
//     expect(s.eos?).to eq(false)
//     expect(s.scan(/\s+/)).to eq(' ')
//     expect(s.scan(/\w+/)).to eq('an')
//     expect(s.scan(/\s+/)).to eq(' ')
//     expect(s.scan(/\w+/)).to eq('example')
//     expect(s.scan(/\s+/)).to eq(' ')
//     expect(s.scan(/\w+/)).to eq('string')
//     expect(s.eos?).to eq(true)
//     expect(s.scan(/\s+/)).to eq(nil)
//     expect(s.scan(/\w+/)).to eq(nil)
// end

it('parses an example string', () => {
    let s = new StringScanner('This is an example string');
    expect(s.eos()).toBe(false);
    expect(s.scan(/\w+/)).toBe('This');
    expect(s.scan(/\w+/)).toBe(null);
    expect(s.scan(/\s+/)).toBe(' ');
    expect(s.scan(/\s+/)).toBe(null);
    expect(s.scan(/\w+/)).toBe('is');
    expect(s.eos()).toBe(false);
    expect(s.scan(/\s+/)).toBe(' ');
    expect(s.scan(/\w+/)).toBe('an');
    expect(s.scan(/\s+/)).toBe(' ');
    expect(s.scan(/\w+/)).toBe('example');
    expect(s.scan(/\s+/)).toBe(' ');
    expect(s.scan(/\w+/)).toBe('string');
    expect(s.eos()).toBe(true);
    expect(s.scan(/\s+/)).toBe(null);
    expect(s.scan(/\w+/)).toBe(null);
});

// it '#concat' do
//     s = StringScanner.new('Fri Dec 12 1975 14:39')
//     s.scan(/Fri /)
//     s.concat(' +1000 GMT')
    
//     expect(s.string).to eq('Fri Dec 12 1975 14:39 +1000 GMT')
//     expect(s.scan(/Dec/)).to eq('Dec')
// end

it('#concat', () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39');
    s.scan(/Fri /);
    s.concat(' +1000 GMT');
      
    expect(s.string()).toBe('Fri Dec 12 1975 14:39 +1000 GMT');
    expect(s.scan(/Dec/)).toBe('Dec');
});

// it '#pos' do
//     s = StringScanner.new('test string')
//     expect(s.pos).to eq(0)
//     expect(s.scan_until(/str/)).to eq('test str')
//     expect(s.pos).to eq(8)
//     s.terminate # sets pos to end of str
//     expect(s.pos).to eq(11)
// end

it('#pos', () => {
    let s = new StringScanner('test string');
    expect(s.pos()).toBe(0);
    expect(s.scan_until(/str/)).toBe('test str');
    expect(s.pos()).toBe(8);
    s.terminate(); // sets pos to end of str
    expect(s.pos()).toBe(11);
});

// it '#setPos' do
//     s = StringScanner.new('test string')
//     s.pos = 7
//     expect(s.pos).to eq(7)
//     expect(s.rest).to eq('ring')
// end

it('#setPos', () => {
    let s = new StringScanner('test string');
    s.setPos(7);
    expect(s.pos()).toBe(7);
    expect(s.rest()).toBe('ring');
});

// it '#charPos' do
//     s = StringScanner.new("abcädeföghi")
//     expect(s.charpos).to eq(0)
//     expect(s.scan_until(/ä/)).to eq('abcä')
//     expect(s.pos).to eq(5)
//     expect(s.charpos).to eq(4)
// end

it('#charpos', () => {
    let s = new StringScanner('abcädeföghi');
    expect(s.charpos()).toBe(0);
    expect(s.scan_until(/ä/)).toBe('abcä');
    // NOTE: In ruby s.pos() is 5 for the  multibyte character. In JS, the position is 4.
    expect(s.pos()).toBe(4);
    expect(s.charpos()).toBe(4);
});

// it '#pointer' do
//     s = StringScanner.new('test string')
//     expect(s.pos).to eq(0)
//     expect(s.scan_until(/str/)).to eq('test str')
//     expect(s.pos).to eq(8)
//     s.terminate # pos is now end of string
//     expect(s.pos).to eq(11)
// end

it('#pointer', () => {
    let s = new StringScanner('test string');
    expect(s.pos()).toBe(0);
    expect(s.scan_until(/str/)).toBe('test str');
    expect(s.pos()).toBe(8);
    s.terminate(); // pos is now end of string
    expect(s.pos()).toBe(11);
});

// it '#setPointer' do
//     s = StringScanner.new('test string')
//     s.pos = 7
//     expect(s.pos).to eq(7)
//     expect(s.rest).to eq('ring')
// end

it('#setPointer', () => {
    let s = new StringScanner('test string');
    s.setPointer(7);
    expect(s.pos()).toBe(7);
    expect(s.rest()).toBe('ring');
});

// it '#scan' do
//     s = StringScanner.new('test string')
//     expect(s.scan(/\w+/)).to eq('test')
//     expect(s.scan(/\w+/)).to eq(nil)
//     expect(s.scan(/\s+/)).to eq(' ')
//     expect(s.scan(/\w+/)).to eq('string')
//     expect(s.scan(/./)).to eq(nil)
// end

it('#scan', () => {
    let s = new StringScanner('test string');
    expect(s.scan(/\w+/)).toBe('test');
    expect(s.scan(/\w+/)).toBe(null);
    expect(s.scan(/\s+/)).toBe(' ');
    expect(s.scan(/\w+/)).toBe('string');
    expect(s.scan(/./)).toBe(null);
});

// it '#skip' do
//     s = StringScanner.new('test string')
//     expect(s.skip(/\w+/)).to eq(4)
//     expect(s.skip(/\w+/)).to eq(nil)
//     expect(s.skip(/\s+/)).to eq(1)
//     expect(s.skip(/\w+/)).to eq(6)
//     expect(s.skip(/./)).to eq(nil)
// end

it('#skip', () => {
    let s = new StringScanner('test string');
    expect(s.skip(/\w+/)).toBe(4);
    expect(s.skip(/\w+/)).toBe(null);
    expect(s.skip(/\s+/)).toBe(1);
    expect(s.skip(/\w+/)).toBe(6);
    expect(s.skip(/./)).toBe(null);
});

// it '#match' do
//     s = StringScanner.new('test string')
//     expect(s.match?(/\w+/)).to eq(4)
//     expect(s.match?(/\w+/)).to eq(4)
//     expect(s.match?(/\s+/)).to eq(nil)
// end

it('#match', () => {
    let s = new StringScanner('test string');
    expect(s.match(/\w+/)).toBe(4);
    expect(s.match(/\w+/)).toBe(4);
    expect(s.match(/\s+/)).toBe(null);
});

// it '#check' do
//     s = StringScanner.new("Fri Dec 12 1975 14:39")
//     expect(s.check(/Fri/)).to eq('Fri')
//     expect(s.pos).to eq(0)
//     expect(s.matched).to eq('Fri')
//     expect(s.check(/12/)).to eq(nil)
//     expect(s.matched).to eq(nil)
// end

it('#check', () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39');
    expect(s.check(/Fri/)).toBe('Fri');
    expect(s.pos()).toBe(0);
    expect(s.matched()).toBe('Fri');
    expect(s.check(/12/)).toBe(null);
    expect(s.matched()).toBe(null);
});

// it '#scan_until' do
//     s = StringScanner.new("Fri Dec 12 1975 14:39")
//     expect(s.scan_until(/1/)).to eq('Fri Dec 1')
//     expect(s.pre_match).to eq('Fri Dec ')
//     expect(s.scan_until(/XYZ/)).to eq(nil)
// end

it('#scan_until', () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39');
    expect(s.scan_until(/1/)).toBe('Fri Dec 1');
    expect(s.pre_match()).toBe('Fri Dec ');
    expect(s.scan_until(/XYZ/)).toBe(null);
});

// it '#skip_until' do
//     s = StringScanner.new("Fri Dec 12 1975 14:39")
//     expect(s.skip_until /12/).to eq(10)
// end

it('#skip_until', () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39');
    expect(s.skip_until(/12/)).toBe(10);
});

// it '#exist' do
//     s = StringScanner.new('test string')
//     expect(s.exist?(/s/)).to eq(3)
//     expect(s.scan(/test/)).to eq('test')
//     expect(s.exist?(/s/)).to eq(2)
//     expect(s.exist?(/e/)).to eq(nil)
// end

it('#exist', () => {
    let s = new StringScanner('test string');
    expect(s.exist(/s/)).toBe(3);
    expect(s.scan(/test/)).toBe('test');
    expect(s.exist(/s/)).toBe(2); // error
    expect(s.exist(/e/)).toBe(null);
});

// it '#check_until' do
//     s = StringScanner.new("Fri Dec 12 1975 14:39")
//     expect(s.check_until(/12/)).to eq('Fri Dec 12')
//     expect(s.pos).to eq(0)
//     expect(s.matched).to eq('12')
// end

it('#check_until', () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39');
    expect(s.check_until(/12/)).toBe('Fri Dec 12');
    expect(s.pos()).toBe(0);
    expect(s.matched()).toBe('12');
});

// it '#getch' do
//     s = StringScanner.new("ab")
//     expect(s.getch).to eq('a')
//     expect(s.getch).to eq('b')
//     expect(s.getch).to eq(nil)

//     s = StringScanner.new("\244\242")
//     # strscan.c s.getch // => "\244\242" doesn't work on Ruby 2.3
//     # instead the characters are returned one at a time.
//     # probably another bug in the example.
//     expect(s.getch).to eq("\xA4")
//     expect(s.getch).to eq("\xA2")
//     expect(s.getch).to eq(nil)
// end

it('#getch', () => {
    let s = new StringScanner('ab');
    expect(s.getch()).toBe('a');
    expect(s.getch()).toBe('b');
    expect(s.getch()).toBe(null);

    s = new StringScanner('\u00A4\u00A2');
    expect(s.getch()).toBe('\xA4');
    expect(s.getch()).toBe('\xA2');
    expect(s.getch()).toBe(null);
});

// it '#get_byte' do
//     s = StringScanner.new("ab")
//     expect(s.get_byte).to eq('a')
//     expect(s.get_byte).to eq('b')
//     expect(s.get_byte).to eq(nil)

//     s = StringScanner.new("\244\242")
//     expect(s.get_byte).to eq("\xA4")
//     expect(s.get_byte).to eq("\xA2")
//     expect(s.get_byte).to eq(nil)
// end

// same as getch
it('#get_byte', () => {
    let s = new StringScanner('ab');
    expect(s.get_byte()).toBe('a');
    expect(s.get_byte()).toBe('b');
    expect(s.get_byte()).toBe(null);

    s = new StringScanner('\u00A4\u00A2');
    expect(s.get_byte()).toBe('\xA4');
    expect(s.get_byte()).toBe('\xA2');
    expect(s.get_byte()).toBe(null);
});

// it '#peek' do
//     s = StringScanner.new('test string')
//     expect(s.peek(7)).to eq("test st")
//     expect(s.peek(7)).to eq("test st")
// end

it('#peek', () => {
    let s = new StringScanner('test string');
    expect(s.peek(7)).toBe('test st');
    expect(s.peek(7)).toBe('test st');
});

// it '#unscan' do
//     s = StringScanner.new('test string')
//     expect(s.scan(/\w+/)).to eq('test')
//     s.unscan
//     expect(s.scan(/../)).to eq('te')
//     expect(s.scan(/\d/)).to eq(nil)
//     # ScanError: unscan failed: previous match record not exist
//     expect{ s.unscan }.to raise_error(StringScanner::Error)
// end

it('#unscan', () => {
    let s = new StringScanner('test string');
    expect(s.scan(/\w+/)).toBe('test');
    s.unscan();
    expect(s.scan(/../)).toBe('te');
    expect(s.scan(/\d/)).toBe(null);

    let scanError = 'ScanError: unscan failed: previous match record not exist';
    expect(() => {
        s.unscan();
      }).toThrowError(scanError);
});

// it '#bol' do
//     s = StringScanner.new("test\ntest\n")
//     expect(s.bol?).to eq(true)
//     s.scan(/te/)
//     expect(s.bol?).to eq(false)
//     s.scan(/st\n/)
//     expect(s.bol?).to eq(true)
//     s.terminate
//     expect(s.bol?).to eq(true)
// end

it('#bol', () => {
    let s = new StringScanner('test\ntest\n');
    expect(s.bol()).toBe(true);
    s.scan(/te/);
    expect(s.bol()).toBe(false);
    expect(s.scan(/st\n/)).toBe('st\n');
    expect(s.bol()).toBe(true);
    s.terminate();
    expect(s.bol()).toBe(true);
});

// it '#beginning_of_line' do
//     s = StringScanner.new("test\ntest\n")
//     expect(s.beginning_of_line?).to eq(true)
//     s.scan(/te/)
//     expect(s.beginning_of_line?).to eq(false)
//     s.scan(/st\n/)
//     expect(s.beginning_of_line?).to eq(true)
//     s.terminate
//     expect(s.beginning_of_line?).to eq(true)
// end

it('#beginning_of_line', () => {
    let s = new StringScanner('test\ntest\n');
    expect(s.beginning_of_line()).toBe(true);
    s.scan(/te/);
    expect(s.beginning_of_line()).toBe(false);
    s.scan(/st\n/);
    expect(s.beginning_of_line()).toBe(true);
    s.terminate();
    expect(s.beginning_of_line()).toBe(true);
});

// it '#eos' do
//     s = StringScanner.new('test string')
//     expect(s.eos?).to eq(false)
//     s.scan(/test/)
//     expect(s.eos?).to eq(false)
//     s.terminate
//     expect(s.eos?).to eq(true)
// end

it('#eos', () => {
    let s = new StringScanner('test string');
    expect(s.eos()).toBe(false);
    s.scan(/test/);
    expect(s.eos()).toBe(false);
    s.terminate();
    expect(s.eos()).toBe(true);
});

// it '#matchedBoolean' do
//     s = StringScanner.new('test string')
//     expect(s.match?(/\w+/)).to eq(4)
//     expect(s.matched?).to eq(true)
//     expect(s.match?(/\d+/)).to eq(nil)
//     expect(s.matched?).to eq(false)
// end

// JS can't have ? in a function name
// s.matched? => s.matchedBoolean()
it('#matchedBoolean', () => {
    let s = new StringScanner('test string');
    expect(s.match(/\w+/)).toBe(4);
    expect(s.matchedBoolean()).toBe(true);
    expect(s.match(/\d+/)).toBe(null);
    expect(s.matchedBoolean()).toBe(false);
});

// it '#matched' do
//     s = StringScanner.new('test string')
//     expect(s.match?(/\w+/)).to eq(4)
//     expect(s.matched).to eq('test')
// end

it('#matched', () => {
    let s = new StringScanner('test string');
    expect(s.match(/\w+/)).toBe(4);
    expect(s.matched()).toBe('test');
});

// it '#matched_size' do
//     s = StringScanner.new('test string')
//     expect(s.check(/\w+/)).to eq('test')
//     expect(s.matched_size).to eq(4)
//     expect(s.check(/\d+/)).to eq(nil)
//     expect(s.matched_size).to eq(nil)
// end

it('#matched_size', () => {
    let s = new StringScanner('test string');
    expect(s.check(/\w+/)).toBe('test');
    expect(s.matched_size()).toBe(4);
    expect(s.check(/\d+/)).toBe(null);
    expect(s.matched_size()).toBe(null);
});

// it '#nthSubgroup' do
//     s = StringScanner.new("Fri Dec 12 1975 14:39")
//     expect(s.scan(/(\w+) (\w+) (\d+) /)).to eq('Fri Dec 12 ')
//     expect(s[0]).to eq("Fri Dec 12 ")
//     expect(s[1]).to eq("Fri")
//     expect(s[2]).to eq("Dec")
//     expect(s[3]).to eq("12")
//     expect(s.post_match).to eq("1975 14:39")
//     expect(s.pre_match).to eq('')

//     s.reset
//     expect(s.scan(/(?<wday>\w+) (?<month>\w+) (?<day>\d+) /)).to eq('Fri Dec 12 ')
//     expect(s[0]).to eq('Fri Dec 12 ')
//     expect(s[1]).to eq('Fri')
//     expect(s[2]).to eq('Dec')
//     expect(s[3]).to eq('12')
//     expect(s[:wday]).to eq('Fri')
//     expect(s[:month]).to eq('Dec')
//     expect(s[:day]).to eq('12')
//     expect(s.post_match).to eq('1975 14:39')
//     expect(s.pre_match ).to eq('')
// end

it('#nthSubgroup', () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39');
    expect(s.scan(/(\w+) (\w+) (\d+) /)).toBe('Fri Dec 12 ');
    expect(s.nthSubgroup(0)).toBe('Fri Dec 12 ');
    expect(s.nthSubgroup(1)).toBe('Fri');
    expect(s.nthSubgroup(2)).toBe('Dec');
    expect(s.nthSubgroup(3)).toBe('12');
    expect(s.post_match()).toBe('1975 14:39');
    expect(s.pre_match()).toBe('');

    // note JavaScript doesn't support <wday> notation or symbols.
    s.reset();
    expect(s.scan(/(\w+) (\w+) (\d+) /)).toBe('Fri Dec 12 ');
    expect(s.nthSubgroup(0)).toBe('Fri Dec 12 ');
    expect(s.nthSubgroup(1)).toBe('Fri');
    expect(s.nthSubgroup(2)).toBe('Dec');
    expect(s.nthSubgroup(3)).toBe('12');
    expect(s.post_match()).toBe('1975 14:39');
    expect(s.pre_match()).toBe('');
});

// it '#pre_match' do
//     s = StringScanner.new('test string')
//     expect(s.scan(/\w+/)).to eq('test')
//     expect(s.scan(/\s+/)).to eq(' ')
//     expect(s.pre_match).to eq('test')
//     expect(s.post_match).to eq('string')
// end

it('#pre_match', () => {
    let s = new StringScanner('test string');
    expect(s.scan(/\w+/)).toBe('test');
    expect(s.scan(/\s+/)).toBe(' ');
    expect(s.pre_match()).toBe('test');
    expect(s.post_match()).toBe('string');
});

// it '#post_match' do
//     s = StringScanner.new('test string')
//     expect(s.scan(/\w+/)).to eq('test')
//     expect(s.scan(/\s+/)).to eq(' ')
//     expect(s.pre_match).to eq('test')
//     expect(s.post_match).to eq('string')
// end

it('#post_match', () => {
    let s = new StringScanner('test string');
    expect(s.scan(/\w+/)).toBe('test');
    expect(s.scan(/\s+/)).toBe(' ');
    expect(s.pre_match()).toBe('test');
    expect(s.post_match()).toBe('string');
});

// it '#inspect' do
//     s = StringScanner.new('Fri Dec 12 1975 14:39')
//     expect(s.inspect).to eq('#<StringScanner 0/21 @ "Fri D...">')
//     expect(s.scan_until(/12/)).to eq('Fri Dec 12')
//     expect(s.inspect).to eq('#<StringScanner 10/21 "...ec 12" @ " 1975...">')
// end

it('#inspect', () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39');
    expect(s.inspect()).toBe('#<StringScanner 0/21 @ "Fri D...">');
    expect(s.scan_until(/12/)).toBe('Fri Dec 12');
    expect(s.inspect()).toBe('#<StringScanner 10/21 "...ec 12" @ " 1975...">');
});