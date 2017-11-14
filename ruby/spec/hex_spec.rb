require_relative 'spec_helper'

describe 'Hex' do

  let(:hex_str) { '27 0F' }
  let(:hex_bin) { "'\x0F" }

  let(:bin_file) { join(__dir__, 'fixtures', 'maxed_0_flask_slot_2.save.bin') }
  let(:hex_file) { join(__dir__, 'fixtures', 'maxed_0_flask_slot_2.save') }
  let(:hex_file_one_line) { join(__dir__, 'fixtures', 'maxed_0_flask_slot_2.save.single_line_hex.txt') }

  it '#hex_to_bin' do
    expect(hex_to_bin(hex_str)).to eq(hex_bin)
  end

  it '#bin_to_hex' do
    expect(bin_to_hex(hex_bin, pretty: true)).to eq(hex_str)
    expect(bin_to_hex(hex_bin, pretty: false)).to eq(hex_str.gsub(' ', ''))
  end

  it '#bin_file_to_hex' do
    expect(bin_file_to_hex(bin_file, pretty: true)).to eq(File.read(hex_file))
  end

  it 'does not corrupt the file' do
    before_file = Digest::SHA256.file bin_file

    bin_file_tmp = bin_file + '.tmp'
    File.binwrite bin_file_tmp, hex_to_bin(bin_file_to_hex(bin_file))

    after_file = Digest::SHA256.file bin_file_tmp
    expect(before_file).to eq(after_file)
  end

  it 'counts flasks in single line hex string' do
    pattern_total = 524
    # empty save should have about 524 empty flask patterns (!!!)
    data = File.read(hex_file_one_line)
    matches = data.scan(/#{empty_flask_pattern}/)
    expect(matches.length).to eq(pattern_total)

    matches = data.scan(/#{flare_flask_pattern}/)
    expect(matches.length).to eq(0)

    # convert all empty flasks to flare
    data.gsub!(empty_flask_pattern, flare_flask_pattern)
    matches = data.scan(/#{flare_flask_pattern}/)
    expect(matches.length).to eq(pattern_total)
  end

  it 'validate flask codes are valid' do
    expected = '8AD2D101AF89E690738003016300000000FFFFFFFFFFFFFFFF8B2A010BB32B010B09000000928103010F2700009C31030163000000'
    expect(flare_flask_pattern).to eq(expected)

    flask_length = 106
    expect(flare_flask_pattern.length).to eq(flask_length)
    expect(electron_flask_pattern.length).to eq(flask_length)
    expect(freeze_flask_pattern.length).to eq(flask_length)
  end
end
