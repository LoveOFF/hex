import  { StringScanner } from './strscan'

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
    let s = new StringScanner('This is an example string')
    expect(s.eos()).toBe(false)
    expect(s.scan(/\w+/)).toBe('This')
    expect(s.scan(/\w+/)).toBe(null)
    expect(s.scan(/\s+/)).toBe(' ')
    expect(s.scan(/\s+/)).toBe(null)
    expect(s.scan(/\w+/)).toBe('is')
    expect(s.eos()).toBe(false)
    expect(s.scan(/\s+/)).toBe(' ')
    expect(s.scan(/\w+/)).toBe('an')
    expect(s.scan(/\s+/)).toBe(' ')
    expect(s.scan(/\w+/)).toBe('example')
    expect(s.scan(/\s+/)).toBe(' ')
    expect(s.scan(/\w+/)).toBe('string')
    expect(s.eos()).toBe(true)
    expect(s.scan(/\s+/)).toBe(null)
    expect(s.scan(/\w+/)).toBe(null)
});

// it '#concat' do
//     s = StringScanner.new('Fri Dec 12 1975 14:39')
//     s.scan(/Fri /)
//     s.concat(' +1000 GMT')
    
//     expect(s.string).to eq('Fri Dec 12 1975 14:39 +1000 GMT')
//     expect(s.scan(/Dec/)).to eq('Dec')
// end

it("#concat", () => {
    let s = new StringScanner('Fri Dec 12 1975 14:39')
    s.scan(/Fri /)
    s.concat(' +1000 GMT')
      
    expect(s.string()).toBe('Fri Dec 12 1975 14:39 +1000 GMT')
    expect(s.scan(/Dec/)).toBe('Dec')
});

// it '#pos' do
//     s = StringScanner.new('test string')
//     expect(s.pos).to eq(0)
//     expect(s.scan_until(/str/)).to eq('test str')
//     expect(s.pos).to eq(8)
//     s.terminate # sets pos to end of str
//     expect(s.pos).to eq(11)
// end

it("#pos", () => {
    let s = new StringScanner('test string')
    expect(s.pos()).toBe(0)
    expect(s.scan_until(/str/)).toBe('test str')
    expect(s.pos()).toBe(8)
    s.terminate() // sets pos to end of str
    expect(s.pos()).toBe(11)
});

// it '#setPos' do
//     s = StringScanner.new('test string')
//     s.pos = 7
//     expect(s.pos).to eq(7)
//     expect(s.rest).to eq('ring')
// end

it("#setPos", () => {
    let s = new StringScanner('test string')
    s.setPos(7)
    expect(s.pos()).toBe(7)
    expect(s.rest()).toBe('ring')
});

// it '#charPos' do
//     s = StringScanner.new("abcädeföghi")
//     expect(s.charpos).to eq(0)
//     expect(s.scan_until(/ä/)).to eq('abcä')
//     expect(s.pos).to eq(5)
//     expect(s.charpos).to eq(4)
// end

it("#charPos", () => {
    let s = new StringScanner("abcädeföghi")
    expect(s.charpos()).toBe(0)
    expect(s.scan_until(/ä/)).toBe('abcä')
    // NOTE: In ruby s.pos() is 5 for the  multibyte character. In JS, the position is 4.
    expect(s.pos()).toBe(4)
    expect(s.charpos()).toBe(4)
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
    let s = new StringScanner('test string')
    expect(s.pos()).toBe(0)
    expect(s.scan_until(/str/)).toBe('test str')
    expect(s.pos()).toBe(8)
    s.terminate() // pos is now end of string
    expect(s.pos()).toBe(11)
});

// it '#setPointer' do
//     s = StringScanner.new('test string')
//     s.pos = 7
//     expect(s.pos).to eq(7)
//     expect(s.rest).to eq('ring')
// end

it('#setPointer', () => {
    let s = new StringScanner('test string')
    s.setPointer(7);
    expect(s.pos()).toBe(7)
    expect(s.rest()).toBe('ring')
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
    let s = new StringScanner('test string')
    expect(s.scan(/\w+/)).toBe('test')
    expect(s.scan(/\w+/)).toBe(null)
    expect(s.scan(/\s+/)).toBe(' ')
    expect(s.scan(/\w+/)).toBe('string')
    expect(s.scan(/./)).toBe(null)
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
    let s = new StringScanner('test string')
    expect(s.skip(/\w+/)).toBe(4)
    expect(s.skip(/\w+/)).toBe(null)
    expect(s.skip(/\s+/)).toBe(1)
    expect(s.skip(/\w+/)).toBe(6)
    expect(s.skip(/./)).toBe(null)
});
