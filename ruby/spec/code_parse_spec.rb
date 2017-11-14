require_relative 'spec_helper'

describe 'Code parser' do

  let(:base) {join(__dir__, '../workspace/treasure_ids')}
  let(:save) {join(base, '__gameplay____slot2__gameplay0.save')}
  let(:save_maxed) {join(base, 'maxed.save')}

  it 'parses expected items from known good save' do
    expected_items = File.read(join(__dir__, 'fixtures/expected_items.txt')).strip
    actual_items = InventoryParse.new(save).print(output_format: :string)
    # File.write(join(__dir__, 'fixtures/expected_items.txt'), actual_items)

    expect(actual_items).to eq(expected_items)
  end

  it 'parses expected maxed items from known good save' do
    expected_items = File.read(join(__dir__, 'fixtures/expected_max_items.txt')).strip
    actual_items = InventoryParse.new(save_maxed).print(output_format: :string)

    # File.write(join(__dir__, 'fixtures/expected_max_items.txt'), actual_items)

    expect(actual_items).to eq(expected_items)
  end

  it 'maxes out items' do
    skip "writing is still WIP"
    maxed_hex = InventoryParse.new(save).modify
    start_hex = bin_file_to_hex(save)

    File.write('C:\Users\surface\code\ruby_hex\spec\fixtures\maxed_hex_single_line.txt', maxed_hex)
    File.write('C:\Users\surface\code\ruby_hex\spec\fixtures\start_hex_single_line.txt', start_hex)

    hex_to_bin_file(save_maxed, maxed_hex)

    # expect(maxed).to eq(start_line)
  end
end
