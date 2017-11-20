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
end
