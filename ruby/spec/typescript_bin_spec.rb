require 'rspec'
require_relative '../../ruby/lib/run_typescript'

describe 'StringScanner' do

  it 'parses the items' do
    ts = RunTypescript.new
    string = ts.get_fake_file

    s = StringScanner.new(string)
    expect(s.scan(/#{ts.item_pattern}/)).to eq(nil)
    s.scan_until(/#{ts.inventory_start}/)
    expect(s.scan(/#{ts.item_pattern}/)).to eq(ts.item_pattern)
    expect(s.scan(/#{ts.item_pattern}/)).to eq(ts.item_pattern)
    expect(s.scan(/#{ts.item_pattern}/)).to eq(nil)
  end

  it 'parses hex correctly' do
    s = StringScanner.new 'd8a2612d7820c83e74500001fff00000d8a2612d7820c83e75'.upcase
    s.scan(/D8 A2 61 2D 78 20 C8 3E (.. .. .. ..) (.. ..) 00 00/x)

    puts s[0] # D8A2612D7820C83E74500001FFF00000
    puts s[1] # 74500001
    puts s[2] # FFF0

    puts 'finished'

=begin
'D8 A2 61 2D 78 20 C8 3E (.. .. .. ..) (.. ..) 00 00';
 d8 a2 61 2d 78 20 c8 3e 03 31 00 01    ff f0  00 00

result: d8a2612d7820c83e74500001fff00000
index range: 0 -> 32

result: 74500001
index range: 0 -> 8 // substr: 16, 8
result: fff0
index range: 9 -> 13 // substr: 24, 4
=end
  end
end
