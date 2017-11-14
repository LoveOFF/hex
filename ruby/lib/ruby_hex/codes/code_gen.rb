# noinspection RubyResolve
class CodeGen
  include Hex
  include InventorySection

  attr_accessor :debug

  def initialize
    @debug = false
  end

  # only 128 codes per cheat allowed.
  # 00000000 00000000 = one code
  # must be float for math
  CODE_LIMIT = 128.0

  # Item Counts
  # Name         Valid  Total  Max
  # Battle Items    52   64   64
  # Key Items      177  208  256
  # Ingredients     77  128  256
  # Treasures      178  256  256
  # Car Parts      124  220  256
  # Leisure Items  105  159  256
  # Weapons        111  200  n/a
  # Accessories    109  130  n/a

  # TODO: codes for key items, ingredients, treasures, car parts, leisure items

  # two types: all or only valid

  # Only used for items. **NOT** accessories/weapons
  def write_item item_code, index
    write_raw_value item_code, index*16
  end

  def write_raw_value item_code, offset
    offset = offset.to_s(16).upcase
    offset = '0' * (6 - offset.length) + offset
    "28#{offset} #{reverse_hex(item_code)}"
  end

  def write_multi code_length
    result = ['4A000004 00000063'] # start at quantity 99

    write_amount = zero_pad_int(code_length, 3)
    result + ["4#{write_amount}0010 00000000"] # increase by zero
  end

  # Used for debugging by setting sequential amounts.
  def write_multi_debug code_length
    result = ['4A000004 00000001'] # start at quantity 1

    write_amount = zero_pad_int(code_length, 3)
    result + ["4#{write_amount}0010 00000001"] # increase by 1
  end

  # returns two arrays for codes matching type
  # [ [ all_ids ], [ valid_ids ] ]
  def items_for_type(type)
    all_ids = []
    valid_ids = []
    AllItems.get.each do |item_code, values|
      _item_name, item_type, item_valid = values
      next unless item_type == type
      all_ids << item_code
      valid_ids << item_code if item_valid
    end

    [all_ids, valid_ids]
  end

  def codes_for_type(type:, search:)
    all_ids_for_type, valid_ids_for_type = items_for_type(type)
    all_codes = []
    valid_codes = []

    type_search_code = to_a(search)

    write_code_count = 2
    all_ids_code_size = type_search_code.length + write_code_count + all_ids_for_type.length
    valid_ids_code_size = type_search_code.length + write_code_count + valid_ids_for_type.length

    all_code_split = (all_ids_code_size / CODE_LIMIT).ceil
    valid_code_split = (valid_ids_code_size / CODE_LIMIT).ceil

    # use write_multi_debug to debug via incrementing counts (x1, x2, x3)
    write_method = @debug ? method(:write_multi_debug) : method(:write_multi)

    (1..all_code_split).each do |split_number|
      # All ids code
      all_ids_for_type_code = type_search_code.clone

      #
      start_index = (128 - write_code_count - type_search_code.length) * (split_number - 1)
      end_index = start_index + (128 - write_code_count - type_search_code.length) - 1
      # puts "#{start_index} -> #{end_index}"

      all_ids_for_type.each_with_index do |code, index|
        next unless (index >= start_index && index <= end_index)
        all_ids_for_type_code << write_item(code, index)
      end

      all_ids_for_type_code.concat(write_method.call(all_ids_for_type.length))
      all_ids_for_type_code.unshift("All #{type} (#{all_ids_for_type.length}) #{split_number} of #{all_code_split}")

      all_codes << all_ids_for_type_code
    end

    # Valid ids code
    (1..valid_code_split).each do |split_number|
      valid_ids_for_type_code = type_search_code.clone

      start_index = (128 - write_code_count - type_search_code.length) * (split_number - 1)
      end_index = start_index + (128 - write_code_count - type_search_code.length) - 1

      valid_ids_for_type.each_with_index do |code, index|
        next unless (index >= start_index && index <= end_index)
        valid_ids_for_type_code << write_item(code, index)
      end

      valid_ids_for_type_code.concat(write_method.call(valid_ids_for_type.length))
      valid_ids_for_type_code.unshift("Valid #{type} (#{valid_ids_for_type.length}) #{split_number} of #{valid_code_split}")

      valid_codes << valid_ids_for_type_code
    end

    [all_codes, valid_codes]
  end

  def to_a(string)
    string.split("\n").map(&:strip)
  end

=begin
Battle item search:

80010008 B2692691
67BCE244 00000000
8801000C 40000000
D8A2612D 7820C83E
92000000 0000000C

Battle item write (id is reversed)

28000000 01003103
<...>

Battle quantity write

4A000004 00000063
40270010 00000000

multi write (4) using offset (A) of 4 (000004) write 99 (00000063)
multi write (4) write 39 times (027) increasing address by 16 (0010) and increasing value by 0 (00000000)

Multi Write
4TXXXXXX YYYYYYYY
4NNNWWWW VVVVVVVV

X= Address/Offset
Y= Value to write (Starting)
N=Times to Write
W=Increase Address By
V=Increase Value By
T=Address/Offset type
Normal/Pointer
0 / 8 = 8bit
1 / 9 = 16bit
2 / A = 32bit

=end
  def battle_items
    search = <<-'S'
      80010008 B2692691
      67BCE244 00000000
      8801000C 40000000
      D8A2612D 7820C83E
      92000000 0000000C
    S
    codes_for_type(type: BATTLE_ITEMS, search: search)
  end

  # aka event items
  def key_items
    search = <<-'S'
      80010008 B2692691
      67BCE244 00000000
      8801000C 00010000
      D8A2612D 7820C83E
      92000000 0000000C
    S
    codes_for_type(type: KEY_ITEMS, search: search)
  end

  def ingredients
    search = <<-'S'
      80010008 B2692691
      67BCE244 00000000
      8802000C 00010000
      D8A2612D 7820C83E
      92000000 0000000C
    S
    codes_for_type(type: INGREDIENTS, search: search)
  end

  def treasures
    search = <<-'S'
      80010008 B2692691
      67BCE244 00000000
      8803000C 00010000
      D8A2612D 7820C83E
      92000000 0000000C
    S
    codes_for_type(type: TREASURES, search: search)
  end

  def car_parts
    search = <<-'S'
      80010008 B2692691
      67BCE244 00000000
      8804000C 00010000
      D8A2612D 7820C83E
      92000000 0000000C
    S
    codes_for_type(type: CAR_PARTS, search: search)
  end

  def leisure_items
    search = <<-'S'
      80010008 B2692691
      67BCE244 00000000
      8805000C 00010000
      D8A2612D 7820C83E
      92000000 0000000C
    S
    codes_for_type(type: LEISURE, search: search)
  end

  # reset flasks 1 - 14
  def reset_magic_code
    result = StringIO.new

    # magic flask 1 starts after 17 matches of magic flasks.
    # flasks 1-16, not sure what they're used for.
    # we start indexing at 1 so 16+1 = 17 .. 31 represents flasks 1 - 14
    base_index = 16
    code_count = 0

    result.puts 'Reset magic flasks (1 of 2)'
    (1..14).each do |index|
      index = base_index + index
      code_count += 1

      if code_count == 8
        result.puts
        result.puts 'Reset magic flasks (2 of 2)'
      end

      index = zero_pad_int(index, 2)
      result.puts "80#{index}0008 8AD2D101
AF89E690 00000000
28000008 01016CE6
2800000C 00000000
28000010 FFFFFF00
28000014 FFFFFFFF
28000018 000000FF
2800001C 00000000
28000020 00000000
28000024 00000000
28000028 00000000
2800002C 00000000
28000030 00000000
08000034 00000000"
    end

    result.string
  end

  # weapon / accessory header
  def header_for_id(id)
    raise 'Id must be 4 bytes' unless id.gsub(' ', '').length == 4*2
    # header is really "B1 96 B1 D3 ED AE 5F 92 #{id}"
    # however we're chopping off one byte to fit within 12 bytes in the search code.

    # the byte after item id changes. maybe 06 or 02 depending on the item.
    "B1 96 B1 D3 ED AE 5F 92 #{id}".gsub(' ', '')
  end

  # Search for first (001) match on 12 bytes (000C)
  #
  # used for weapons / accessories
  #
  # 8001000C XXXXXXXX
  # XXXXXXXX XXXXXXXX
  def search_for_header(header_id)
    raise "Header is nil" unless header_id
    expected_len = 12 * 2
    raise "Invalid header length #{header_id.length} != #{expected_len}\n#{header_id}" unless header_id.length == expected_len
    header_id = header_id.upcase
    result = []
    result << "8001000C #{header_id[0...8]}"
    result << "#{header_id[8...16]} #{header_id[16...24]}"
  end

  def code_for_weapon_or_accessory(filler_array:, type:)
    all_ids_for_type, valid_ids_for_type = items_for_type(type)
    all_codes = []
    valid_codes = []
    tmp_array = filler_array.dup

    # 8001000C XXXXXXXX
    # XXXXXXXX XXXXXXXX
    # 28000008 YYYYYYYY
    all_ids_code_size = all_ids_for_type.length
    valid_ids_code_size = valid_ids_for_type.length

    # size * 3 because we're generating 3 codes per id (2 search, one write)
    codes_per_id = 3
    all_code_split = (all_ids_code_size * codes_per_id / CODE_LIMIT).ceil
    valid_code_split = (valid_ids_code_size * codes_per_id / CODE_LIMIT).ceil

    # Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F
    #            B1 96 B1 D3 ED AE 5F 92 02   66 03 01 06 FF
    #                                    ^
    #                                     \ offset for item id.
    item_offset = 8

    (1..all_code_split).each do |split_number|
      start_index = (128 / codes_per_id) * (split_number - 1)
      end_index = start_index + (128 / codes_per_id) - 1
      # puts "#{start_index} -> #{end_index}"
      all_ids_for_type_code = []

      all_ids_for_type.each_with_index do |id, index|
        next unless (index >= start_index && index <= end_index)
        raise "Filler exhausted. Are you sure there is enough?" if tmp_array.empty?
        search = search_for_header tmp_array.shift

        all_ids_for_type_code.concat(search)
        all_ids_for_type_code << write_raw_value(id, item_offset)
      end

      all_ids_for_type_code.unshift("All #{type} (#{all_ids_for_type.length}) #{split_number} of #{all_code_split}")

      all_codes << all_ids_for_type_code
    end

    # Valid ids code
    tmp_array = filler_array.dup
    (1..valid_code_split).each do |split_number|
      valid_ids_for_type_code = []
      start_index = (128 / codes_per_id) * (split_number - 1)
      end_index = start_index + (128 / codes_per_id) - 1

      valid_ids_for_type.each_with_index do |id, index|
        next unless (index >= start_index && index <= end_index)
        search = search_for_header tmp_array.shift
        valid_ids_for_type_code.concat(search)
        valid_ids_for_type_code << write_raw_value(id, item_offset)
      end

      valid_ids_for_type_code.unshift("Valid #{type} (#{valid_ids_for_type.length}) #{split_number} of #{valid_code_split}")

      valid_codes << valid_ids_for_type_code
    end

    [all_codes, valid_codes]
  end

  # Setup: Buy the following from Culless Munitions - Hammerhead
  # 99x Broadsword (Swords)
  # 99x Two-handed Sword (Greatswords)
  # 99x War Sword (Greatswords)
  # 99x Daggers (Daggers)
  # 99x Avengers (Avengers)
  def weapons
    broadsword = header_for_id('F4 65 03 01')
    two_handed_sword = header_for_id('01 66 03 01')
    war_sword = header_for_id('02 66 03 01')
    daggers = header_for_id('1B 66 03 01')
    avengers = header_for_id('1C 66 03 01')
    filler_array = [broadsword] * 99 +
                   [two_handed_sword] * 99 +
                   [war_sword] * 99 +
                   [daggers] * 99 +
                   [avengers] * 99
    raise 'invalid length' unless filler_array.length == 5 * 99
    type = WEAPONS

    code_for_weapon_or_accessory(filler_array: filler_array, type: type)
  end

=begin

Accessory info

magitek v2 = 3D 78 03 01

B1 96 B1 D3 ED AE 5F 92 ?? ?? ?? ?? 06

B196B1D3EDAE5F923D78030106

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

00243FD0               B1 96 B1 D3  ED AE 5F 92 3D 78 03 01       ±–±Óí®_’=x
00243FE0   06 FF FF FF FF FF FF FF  FF D5 18 01 0B 30 00 00    ÿÿÿÿÿÿÿÿÕ   0
00243FF0   00 41 00 00 00 00 00 00  00 00 00 00 00 00 00 00    A
00244000   00 00 00 00 00 02 00 00  00 02 00 00 00 99 32 C5                ™2Å
00244010   C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 99 32 C5   ÄÌWmC'ž  ÿÿÿÿ™2Å
00244020   C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 01 00 00   ÄÌWmC'ž  ÿÿÿÿ
00244030   00 99 32 C5 C4 CC 57 6D  43 27 9E 00 01 FF FF FF    ™2ÅÄÌWmC'ž  ÿÿÿ
00244040   FF 13 00 00 00 64 00 00  00 46 00 00 00 00 00 00   ÿ    d   F
00244050   00 00 00 00 00 D0 07 00  00 00 00 00 00 00 00 00        Ð
00244060   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00244070   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00244080   00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00244090   00 01 00 00 00
=end

  # Setup: Buy the following from the Regalia shop.
  # 99x Titanium Bangle (+200 HP)
  # 99x Heliodor Bracelet (+40 STR)
  def accessories
    titanium_bangle = header_for_id('0C 78 03 01')
    heliodor_bracelet = header_for_id('1C 78 03 01')

    type = ACCESSORIES

    filler_array = [titanium_bangle] * 99 + [heliodor_bracelet] * 99
    raise 'invalid length' unless filler_array.length == 2 * 99

    code_for_weapon_or_accessory(filler_array: filler_array, type: type)
  end
end
