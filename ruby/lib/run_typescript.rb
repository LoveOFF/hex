require_relative 'ruby_hex'

# Find inventory start:
#                    /B2 69 26 91 67 BC E2 44 40 00 00 00/x
#
# then print item ids & counts:
#     /D8 A2 61 2D 78 20 C8 3E .. .. .. .. .. .. 00 00/x


class RuntTypescript
  include Hex

  def inventory_start
    'B2 69 26 91 67 BC E2 44 40 00 00 00'
  end

  def item_pattern
    'D8 A2 61 2D 78 20 C8 3E FF FF FF FF AA AA 00 00'
  end

  def make_fake_file
    hex = inventory_start + item_pattern * 2

    bin_file = 'fake_item_file.bin'
    hex_to_bin_file(bin_file, hex)

    puts "Created file..."
    puts bin_file_to_hex(bin_file, pretty: true)
  end
end


RuntTypescript.new.make_fake_file
