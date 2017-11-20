import  { StringScanner } from './strscan'

it('constructs a StringScanner object', () => {
    let s = new StringScanner('This is an example string')
    expect(s.eos()).toBe(false);

    expect(s.scan(/\w+/)).toBe("This");
    expect(s.scan(/\w+/)).toBe(" is");
    expect(s.scan(/\w+/)).toBe(" an");
    expect(s.scan(/\w+/)).toBe(" example");
    expect(s.scan(/\w+/)).toBe(" string");
    expect(s.scan(/\w+/)).toBe(null);
});
