require_relative 'ruby_hex'

class HexCompare
  include Hex

  def slot_path(slot)
    raise 'Invalid slot number' unless slot.to_s.match(/^\d$/)
    join(@base, "__gameplay____slot#{slot}__gameplay0.save")
  end

  def slot_bin(slot)
    File.binread(slot_path(slot))
  end

  def initialize
    @base = 'C:\Users\surface\Desktop\ps4\saves\FF_XV\aranea_debug\decrypted_set_2'
    @slot_6 = slot_bin 6 # present
    @slot_7 = slot_bin 7 # present
    @slot_8 = slot_bin 8 # removed
    @slot_9 = slot_bin 9 # removed

    puts "slot 6: #{@slot_6.size}"
    puts "slot 7: #{@slot_7.size}"
    puts "slot 8: #{@slot_8.size}"
    puts "slot 9: #{@slot_9.size}"

    raise 'Size mismatch slot 6 != 7' unless @slot_6.size == @slot_7.size
    # for some reason... the removal save is always larger
    raise 'Size mismatch slot 8 != 9' unless @slot_8.size == @slot_9.size

    slot_6_hex = bin_to_hex(@slot_6)
    slot_7_hex = bin_to_hex(@slot_7)
    slot_8_hex = bin_to_hex(@slot_8)
    slot_9_hex = bin_to_hex(@slot_9)

    # ignore everything until this string... maybe helps with random file size difference
    split_rgx = /00 00 00 00 00 00 00 00 00 00 93 57 28 08 CD 16 E3 79 05 B7 05 01 D6 04 00 00 00 00 00 00 00/x

    [slot_6_hex, slot_7_hex, slot_8_hex, slot_9_hex].each do |slot|
      scanner = StringScanner.new(slot)
      scanner.scan_until(split_rgx)

      raise "Split point not found for: #{split_rgx}" if scanner.pos == 0
      puts "new end pos: #{scanner.pos}"
    end
    exit

    slot_6_hex = slot_6_hex.split('')
    slot_7_hex = slot_7_hex.split('')
    slot_8_hex = slot_8_hex.split('')
    slot_9_hex = slot_9_hex.split('')


    puts 'writing bins'

    # remove changes from saves that are the same
    # in this case, both saves don't contain the extra party member
    slot_6_hex.each_with_index do |char, index|
      if char != slot_7_hex[index]
        slot_6_hex[index] = slot_7_hex[index] = 'E'
      end
    end

    slot_8_hex.each_with_index do |char, index|
      if char != slot_9_hex[index]
        slot_8_hex[index] = slot_9_hex[index] = 'E'
      end
    end

    File.write slot_path(6) + '.bin', hex_to_bin(slot_6_hex.join)
    File.write slot_path(7) + '.bin', hex_to_bin(slot_7_hex.join)
    File.write slot_path(8) + '.bin', hex_to_bin(slot_8_hex.join)
    File.write slot_path(9) + '.bin', hex_to_bin(slot_9_hex.join)
    puts 'finished'
  end
end

HexCompare.new

=begin

New Saves:

- 2,3,4,5 -- have arena
- 6,7,8,9 -- no arena

pitoss removal method


top -- always different.
very bottom - always different.

=end
