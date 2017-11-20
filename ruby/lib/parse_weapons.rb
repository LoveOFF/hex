def s_to_h string
  string.gsub(/\s/, '')
end

# need five (!!!) dummy weapons.  5 * 99 = 495
# weapon count: 463x ids
#
# 1          2                 3            4   5
# war_sword, two_handed_sword, broad_sword, Daggers, Avengers

def empty_weapon
  s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  25 AA 01 01 00 FF FF FF
    FF 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 00 00 00 00 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 00 00 00 00 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 00 00 00  00 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00
  S
end

# 1B 66 03 01 -> Daggers
# B196B1D3EDAE5F921B660301
# [item id] [02 / 06] ?? not sure why it's different sometimes.
def daggers
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  1B 66 03 01 .. FF FF FF
    FF .. .. .. .. 4A 19 01  0B 03 00 00 00 08 00 00
    00 14 00 00 00 00 00 00  00 07 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 90 6B 03 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 05 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 04 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

# 1C 66 03 01 -> Avengers
# B196B1D3EDAE5F921C660301
def avengers
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  1C 66 03 01 .. FF FF FF
    FF .. .. .. .. 4B 19 01  0B 03 00 00 00 08 00 00
    00 2B 00 00 00 00 00 00  00 07 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 9A 6B 03 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 05 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 04 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

#                         02 66 03 01 -> War Sword (Greatswords)
# B1 96 B1 D3 ED AE 5F 92 02 66 03 01
# B196B1D3EDAE5F9202660301
def war_sword # todo: check this matches when 5 are bought
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  02 66 03 01 .. FF FF FF
    FF .. .. .. .. 31 19 01  0B 01 00 00 00 10 00 00
    00 4E 00 00 00 00 00 00  00 01 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 9F 6B 03 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 41 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

#                         01 66 03 01 -- Two Handed sword (Greatswords)
# B1 96 B1 D3 ED AE 5F 92 01 66 03 01
# B196B1D3EDAE5F9201660301
def two_handed_sword
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  01 66 03 01 .. FF FF FF
    FF .. .. .. .. 30 19 01  0B 01 00 00 00 08 00 00
    00 30 00 00 00 00 00 00  00 01 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 89 6B 03 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 35 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

#                         F4 65 03 01 -- Broad Sword (Swords)
# B1 96 B1 D3 ED AE 5F 92 F4 65 03 01
# B196B1D3EDAE5F92F465030106
#
# some saves have different data:
# B196B1D3EDAE5F92F465030106FFFFFFFF00000000
# B196B1D3EDAE5F92F465030106FFFFFFFFFFFFFFFF
#
# search for:
#            B1 96 B1 D3 ED AE 5F 92 F4 65 03 01 06
#
# the 06 is important to find those in the inventory.
def broad_sword
  # use regexp since .. is used for wildcard
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  F4 65 03 01 .. FF FF FF
    FF .. .. .. .. 23 19 01  0B 00 00 00 00 08 00 00
    00 2A 00 00 00 00 00 00  00 02 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 87 6B 03 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 06 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

def handgun
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  28 66 03 01 .. FF FF FF
    FF .. .. .. .. 57 19 01  0B 04 00 00 00 08 00 00
    00 20 00 00 00 00 00 00  00 01 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 91 6B 03 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 04 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

# 05 == equipt? 03 -- not equpt?
# 27 66 03 01 03 - Mage Mashers (Daggers)
def mage_mashers
  s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  27 66 03 01 03 FF FF FF
    FF FF FF FF FF 56 19 01  0B 03 00 00 00 1E 00 00
    00 42 00 00 00 00 00 00  00 07 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 A7 6B 03 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 20 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 0D 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

# 26 66 03 01 - Zwill Crossblades (Daggers)
def zwill_crossblades
  s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  26 66 03 01 02 02 00 00
    00 00 00 00 00 55 19 01  0B 03 00 00 00 63 00 00
    00 59 01 00 00 00 00 00  00 07 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 9D 6B 03 01 05 00 00  00 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 19 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 05 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

def squeaky_hammer
  s_to_h 'F5 0B 03 01 02' # [3] correct. no desc
end

def death_penalty
  s_to_h '33 66 03 01 02' # [4] correct.
end

def apocalypse
  s_to_h '0C 66 03 01 02' # [5] correct.
end

def balmung
  s_to_h 'FF 65 03 01 02' # [6] correct
end

def flayer
  s_to_h '19 66 03 01 02' # [7] correct
end

def drill_breaker_plus
  s_to_h '4C 9E 03 01 06' # [8] correct
end

def noiseblaster_plus
  s_to_h '4B 9E 03 01 06' # [9] correct
end

def gravity_well_plus
  s_to_h '49 9E 03 01 06' # [10] correct
end

require_relative '../lib/ruby_hex'
class ParseWeapons
  include Hex
  include SaveWizard


  def save_for_slot slot_number
    join(__dir__, "..\\workspace\\weapons_sold\\__gameplay____slot#{slot_number}__gameplay0.save")
  end

  def modify_save_for_slot slot_number
    join(__dir__, "..\\workspace\\weapons_sold\\modify\\__gameplay____slot#{slot_number}__gameplay0.save")
  end

  # Replace Broadsword with Zwill Crossbaldes
  def modify
    save = modify_save_for_slot(2)

    save_hex = bin_file_to_hex save
    before_length = save_hex.length
    broad_sword_count = save_hex.scan(broad_sword).length
    puts "[before] Broad sword x#{broad_sword_count}"

    save_hex.gsub!(broad_sword, zwill_crossblades)
    after_length = save_hex.length
    raise 'Save corrupted!' unless before_length == after_length

    broad_sword_count = save_hex.scan(broad_sword).length
    puts "[after] Broad sword x#{broad_sword_count}"

    hex_to_bin_file(save, save_hex)

    FileUtils.cp save, 'C:\Users\surface\AppData\Local\Temp\SWPS4MAX\__gameplay____slot2__gameplay0.save'
  end

  def validate_item_id item_id
    raise 'Item id should be 4 bytes (len 8)' unless item_id.gsub(' ', '').length == 8
    item_id
  end

  def item_for_id item_id
    validate_item_id(item_id)
    "B1 96 B1 D3 ED AE 5F 92 #{item_id}".gsub(' ', '')
  end

  def full_item_for_id item_id
    validate_item_id(item_id)

    s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  #{item_id}  02 02 00 00
    00 00 00 00 00 55 19 01  0B 03 00 00 00 63 00 00
    00 59 01 00 00 00 00 00  00 07 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 9D 6B 03 01 05 00 00  00 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 19 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 05 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
    S
  end

  def modify2
    save = modify_save_for_slot(2)

    save_hex = bin_file_to_hex save
    before_length = save_hex.length

    # modify
    # replace: Broad sword / Two handed sword / War sword

    # B1 96 B1 D3 ED AE 5F 92  ?? ?? ?? ??
    weapon_codes = []
    weapon_index = -1
    all_weapons.each do |hex_code, values|
      weapon_codes << hex_code
    end

    [broad_sword, two_handed_sword, war_sword].each do |known_item|
      save_hex.gsub!(known_item) do
        if weapon_index >= weapon_codes.length
          known_item
        else
          weapon_index += 1
          hex_code = weapon_codes[weapon_index]
          new_code = item_for_id hex_code
          new_code + broad_sword[new_code.length..-1]
        end
      end
    end

    after_length = save_hex.length
    raise 'Save corrupted!' unless before_length == after_length

    puts "Added #{weapon_index} weapons"

    hex_to_bin_file(save, save_hex)
    FileUtils.cp save, 'C:\Users\surface\AppData\Local\Temp\SWPS4MAX\__gameplay____slot2__gameplay0.save'
  end

  def all_weapons
    AllItems.get.select {|_key, values| values[1] == 'Weapons [10]'}
  end

  # all weapons, including invalid
  def all_weapons_codes
    weapon_codes = []
    all_weapons.each do |hex_code, values|
      weapon_codes << hex_code
    end
    weapon_codes
  end

  def invalid_weapons_codes
    weapon_codes = []
    all_weapons.each do |hex_code, values|
      # values: [item_name, item_type, item_valid]
      weapon_codes << hex_code unless values.last
    end
    weapon_codes
  end

  def valid_weapons_codes
    weapon_codes = []
    all_weapons.each do |hex_code, values|
      # values: [item_name, item_type, item_valid]
      weapon_codes << hex_code if values.last
    end
    weapon_codes
  end

  def find_known_weapons
    save = save_for_slot 2
    save_hex = bin_file_to_hex save

    weapons = all_weapons

    matches = Hash.new 0

    weapon_prefix = 'B1 96 B1 D3 ED AE 5F 92'
    weapons.each do |hex_code, values|
      matches[hex_code] += save_hex.scan(/#{weapon_prefix} #{hex_code}/x).length
    end

    # print missing
    missing_count = 0
    matches.each do |match_key, match_value|
      missing_code = pretty_hex(weapon_prefix.gsub(' ', '') + match_key)
      if match_value == 0
        puts missing_code
        missing_count += 1
      end
    end

    puts "Missing #{missing_count} weapons"

  end

  def run
    slots = [2, 3, 4, 5]
    slots.each do |slot|
      puts "Slot #{slot}"
      save = save_for_slot slot

      save_hex = bin_file_to_hex save

      broad_sword_count = save_hex.scan(broad_sword).length
      puts "Broad sword x#{broad_sword_count}" if broad_sword_count > 0

      two_handed_sword_count = save_hex.scan(two_handed_sword).length
      puts "Two handed sword x#{two_handed_sword_count}" if two_handed_sword_count > 0

      war_sword_count = save_hex.scan(war_sword).length
      puts "War sword x#{war_sword_count}" if war_sword_count > 0
      puts

      weapons_txt_for_file save
    end
  end

  # def run

  def weapons_txt_for_file(save_file_path)
    save_hex = bin_file_to_hex save_file_path

    # note: not all valid weapons have FF FF FF after the item name. ex: zwill
    matched_items = save_hex.scan(/B1 96 B1 D3 ED AE 5F 92 (.. .. .. .. ..)/x)

    item_count = Hash.new 0
    matched_items.map! do |item|
      item = pretty_hex(item.first)
      item_count[item] += 1
      item
    end

    # sort by key to enable text diffing
    item_count = item_count.sort_by {|key, _value| key}

    item_count_str = ''
    item_count.each do |key, value|
      item_count_str += "#{key} x#{value}\n"
    end

    txt_file = save_file_path + '.weapons.txt'
    puts "Writing: #{txt_file}"
    File.write(txt_file, item_count_str)
  end

  def glob_weapons_txt root_path
    raise "Path doesn't exist: #{root_path}" unless File.directory?(root_path)
    glob_path = File.expand_path(File.join(root_path, '**/*.save'))
    puts "Globbing: #{glob_path}"
    Dir.glob(glob_path) do |save_file|
      next if File.directory?(save_file)
      weapons_txt_for_file(save_file)
    end
  end

  def item_prefix
    'B1 96 B1 D3 ED AE 5F 92'.gsub(' ', '')
  end

  def item_regex
    /#{item_prefix} .{370}#{item_prefix}/x
  end

  def replace_all_weapons(save_file_path, item_id)
    save_hex = bin_file_to_hex save_file_path
    before_length = save_hex.length

    # when overriding all item using only an id, 216 show up.
    # TODO: gsub *entire* item code and replace it with id + known valid code body
    # then see how many show up.
    sub_count = 0
    sub_max = 500 # category max seems to be 501?
    full_item = full_item_for_id(item_id)

    # only gsub if it's followed by another item. otherwise the game will crash
    save_hex.gsub!(/#{item_prefix} .{370}#{item_prefix}/x) do |match|
      if sub_count < sub_max
        sub_count += 1
        full_item + item_prefix
      else
        match
      end
    end

    puts "Added: #{sub_count} weapons"

    # added item count is 1025 (!!)
    # 1025 apocalypse written -> 501x visible apocalypse [slot 2 from USB flash drive]
    # 30 sequential items per save (~496 slots) ... can discover all items in 7 slots
    puts "Added item count: #{save_hex.scan(full_item).length}"

    raise 'Save corrupted!' unless before_length == save_hex.length

    hex_to_bin_file(save_file_path, save_hex)
  end

  def update_override_weapons
    test_weapons = [squeaky_hammer, death_penalty, apocalypse, balmung, flayer, drill_breaker_plus, noiseblaster_plus, gravity_well_plus]
    test_weapons = [apocalypse] # just apocalypse for now
    start_index = 2
    raise 'must use weapon count <= 8' unless test_weapons.length <= 8
    test_weapons.each do |weapon_id|
      weapon_id = weapon_id.gsub(' ', '')[0...4 * 2] # use first four bytes
      target_save = "C:\\Users\\surface\\code\\ruby_hex\\workspace\\compare_weapons\\override\\__gameplay____slot#{start_index}__gameplay0.save"
      replace_all_weapons(target_save, weapon_id)
      start_index += 1
    end
  end

  def debug_weapon_ids(opts = {})
    # divide all weapons into chunks up to size 30 (max sequential count of 496)
    # start counting at 2 since some items will be at x1
    # make sure < 500 item limit observed with apoc. after that items may not show up
    # (2..30).to_a.inject(0, :+) # 464
    invalid_options = opts.keys - %i[chunk_max_size all_weapon_codes]
    raise "Invalid options: #{invalid_options.join(', ')}" unless invalid_options.empty?
    chunk_size = 1
    chunk_max_size = opts.fetch(:chunk_max_size, 29)
    weapon_codes = opts.fetch(:all_weapon_codes, all_weapons_codes)

    weapon_chunks = []
    tmp_chunk = []

    weapon_codes.each do |weapon_code|
      chunk_size += 1

      tmp_chunk << weapon_code

      if chunk_size > chunk_max_size
        chunk_size = 1
        weapon_chunks << tmp_chunk
        tmp_chunk = []
      end
    end

    weapon_chunks << tmp_chunk

    weapon_count = weapon_chunks.map {|e| e.uniq.length}
    puts "Weapon count: #{weapon_count} (#{weapon_count.inject(0, :+)})" # not 200 when using only invalid weapons
    # raise 'Weapon count is not 200' unless weapon_count.reduce(0, &:+) == 200

    # use slots 2 - 9
    raise 'Chunk size exceeds slot count' unless weapon_chunks.length <= 8
    weapon_chunks.each_with_index do |chunk_array, index|
      count_offset = 2 # start at 2.
      slot_num = index + 2
      target_save = "C:\\Users\\surface\\code\\ruby_hex\\workspace\\compare_weapons\\override\\__gameplay____slot#{slot_num}__gameplay0.save"
      save_hex = bin_file_to_hex target_save
      save_hex_before_length = save_hex.length

      # delete any existing weapons
      # note: gusbbing all items out deleted 6 of the armiger weapons
      save_hex.gsub!(/#{item_prefix} .{370}#{item_prefix}/x) do
        empty_weapon + item_prefix
      end

      puts "Slot ##{slot_num}"

      weapons_to_check = []

      next_valid_item = 0
      chunk_array.each do |weapon_code|
        puts "#{pretty_hex(weapon_code)} x#{count_offset}"
        # for count_offset times, add the weapon code

        full_item = full_item_for_id(weapon_code)
        item_prefix = 'B1 96 B1 D3 ED AE 5F 92'.gsub(' ', '')

        current_gsubs = -1
        new_item = full_item + item_prefix
        weapons_to_check << [new_item, count_offset]
        item_count = 0

        # only gsub if it's followed by another item. otherwise the game will crash
        save_hex = save_hex.gsub(/#{item_prefix} .{370}#{item_prefix}/x) do |match|
          # avoid subbing the same item over and over again.
          current_gsubs += 1

          if next_valid_item == current_gsubs && (item_count < count_offset)
            next_valid_item += 1
            item_count += 1
            new_item
          else
            match
          end
        end
        raise 'sub failed' if save_hex == nil

        found_length = save_hex.scan(full_item).length
        insert_successful = found_length == count_offset
        raise "Inserted item count not found: #{weapon_code} x#{count_offset} != x#{found_length}" unless insert_successful

        count_offset += 1
      end

      # check all inserted weapons actually exist instead of just the last inserted item.
      weapons_to_check.each do |weapon_id, weapon_count|
        found_length = save_hex.scan(weapon_id).length
        insert_successful = found_length == weapon_count
        raise "Inserted item count not found: #{weapon_id[16..8 + 16]} x#{found_length} != x#{weapon_count}" unless insert_successful
      end

      raise 'Save corrupted' unless save_hex_before_length == save_hex.length

      hex_to_bin_file(target_save, save_hex)

      puts
    end
  end


  # slot_range.each do |slot_num|
  #   target_save = "C:\\Users\\surface\\code\\ruby_hex\\workspace\\compare_weapons\\override\\__gameplay____slot#{slot_num}__gameplay0.save"
  #   replace_all_weapons(target_save, weapon_id)
  #   start_index += 1
  # end

  def read_slot_tmp
    # ~1026 apocalypse ... only 501 show up in game... maybe category limit?
    # if we added exactly 500.... would all 500 show up? yes!! that worked.
    # todo: use save with all items sold..... add 500 apoc ... save to each slot... then map out all the item ids!
    save_file_path = "C:\\Users\\surface\\code\\ruby_hex\\workspace\\compare_weapons\\501_apocalypse\\__gameplay____slot2__gameplay0.save"

    # 1 preexisting apoc + 500 inserted.
    save_file_path = "C:\\Users\\surface\\code\\ruby_hex\\workspace\\compare_weapons\\500_apocalypse\\__gameplay____slot2__gameplay0.save"

    save_hex = bin_file_to_hex save_file_path

    weapon = apocalypse[0...4 * 2] # use first four bytes
    weapon_code = item_for_id(weapon)

    found_matches = save_hex.scan(/#{weapon_code} (..)/x)
    puts "len: " + found_matches.length.to_s

    item_count = Hash.new 0
    found_matches.map! do |item|
      item = pretty_hex(item.first)
      item_count[item] += 1
      item
    end

    puts item_count
  end

  # add all weapons by replacing broad sword/two handed sword/war sword
  # all_items = including debug
  def save_wizard(slot, opts = {})
    all_items = opts.fetch(:all_items, true)

    weapons_array = all_items ? all_weapons_codes : valid_weapons_codes

    save_wizard_target_slot = slot
    save_hex = bin_file_to_hex save_wizard_target_slot
    save_hex_before_length = save_hex.length

    broad_sword_count = save_hex.scan(broad_sword).length
    puts "Broad sword x#{broad_sword_count}"
    raise 'broad_sword_count must be > 90' unless broad_sword_count > 90

    two_handed_sword_count = save_hex.scan(two_handed_sword).length
    puts "Two handed sword x#{two_handed_sword_count}"
    raise 'two_handed_sword_count must be > 90' unless two_handed_sword_count > 90

    war_sword_count = save_hex.scan(war_sword).length
    puts "War sword x#{war_sword_count}"
    raise 'war_sword_count must be > 90' unless war_sword_count > 90

    dagger_count = save_hex.scan(daggers).length
    puts "Daggers x#{dagger_count}"
    raise 'dagger_count must be > 90' unless dagger_count > 90

    avengers_count = save_hex.scan(avengers).length
    puts "Avengers x#{avengers_count}"
    raise 'avengers_count must be > 90' unless avengers_count

    handgun_count = save_hex.scan(handgun).length
    puts "Handgun x#{handgun_count}"
    raise 'handgun_count must be > 90' unless handgun_count
    puts

    weapon_codes_length = weapons_array.length
    puts "Total weapon codes: #{weapon_codes_length}"
    weapon_index = -1

    # gsub direct without matching on next item prefix. works because we know the full content of the item.
    dummy_weapons = [broad_sword, two_handed_sword, war_sword, daggers, avengers, handgun]

    weapon_count = 0
    dummy_weapons.each do |dummy_weapon|
      save_hex.gsub!(dummy_weapon) do |match|
        weapon_index += 1
        valid_index = weapon_index < weapon_codes_length
        if valid_index
          weapon_count += 1
          item_id = weapons_array[weapon_index]
          full_item_for_id(item_id)
        else
          match
        end
      end
    end
    raise 'Save corrupted' unless save_hex_before_length == save_hex.length

    weapons_array.each do |weapon_code|
      puts "Missing weapon: #{weapon_code}" unless save_hex.scan(full_item_for_id(weapon_code)).length > 0
    end

    puts "Added #{weapon_count}x weapons"

    hex_to_bin_file(save_wizard_target_slot, save_hex)
  end
end

# ---------

# > (2..13).to_a.length => 12
# > (2..13).to_a.inject(0, :+) => 90
# > 12 * 8 => 96
# parse_weapons.debug_weapon_ids(
#     chunk_max_size: 12,
#     all_weapon_codes: parse_weapons.invalid_weapons_codes)

# parse_weapons.read_slot_tmp
# parse_weapons.update_override_weapons

# parse_weapons.run
# parse_weapons.modify
# parse_weapons.modify2

# parse_weapons.glob_weapons_txt('C:\Users\surface\code\ruby_hex\workspace\compare_weapons')

# parse_weapons.find_known_weapons

# Slot 2 - Broad sword x5
# Slot 3 - Two handed sword x5
# Slot 4 - ??
# Slot 5  - War sword x5

=begin
new idea:
 * buy up 99x Broadsword, War Sword, Two handed sword
 * replace with all weapon ids

replacing with weapon ids works... now to map them back to item names.

-> Delete one weapon per save?
-> Figure out how items change when they're equipt vs not equipt?

-----

patch v1.13 update
* new ids?


-----



slot 2 (in game 3)
Gear List (Weapon sell menu):

   -- 5x Broadsword (F4 65 03 01) -- [slot 2, in game 3]
 1 - Blazefire Saber - DLC
 2 - Ragnarok - DLC
   -- 5x Two-handed sword -- [slot 3, in game 4]
 3 - Apocalypse - Equipt (Gladio)
 4 - Masamune - DLC
 5 - Genji Blade - DLC
 6 - Gae Bolg - DLC
 7 - Zwill Crossblades - Equipt (Ignis)
 8 - Mage Mashers - DLC
 9 - Death Penalty - Equipt (Prompto)
10 - Lion Heart - DLC


weapon order appears random in the save file



sold daggers:

F4 65 03 01 04 x96 -> x95
27 66 03 01 03 x1 -> 27 66 03 01 05 x1
^-- maybe this is Ignis equipment number?


27 66 03 01 03 x1 [present]
27 66 03 01 05 x1 [sold]
26 66 03 01 00 x1 [sold]


B196B1D3EDAE5F922766030103

=end
