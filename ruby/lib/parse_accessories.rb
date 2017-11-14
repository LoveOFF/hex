def s_to_h string
  string.gsub(/\s/, '')
end

# B1 96 B1 D3 ED AE 5F 92 ?? ?? ?? ?? 06
# B1 96 B1 D3 ED AE 5F 92 0C 78 03 01 06 # titanium_bangle
def titanium_bangle_weapon_code
  s_to_h('0C 78 03 01')
end

# 0C 78 03 01 => 0C780301
def titanium_bangle
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  0C 78 03 01 .. FF FF FF
    FF .. .. .. .. AE 18 01  0B 30 00 00 00 04 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 C8 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

# B1 96 B1 D3 ED AE 5F 92 ?? ?? ?? ?? 06
# B1 96 B1 D3 ED AE 5F 92 1C 78 03 01 06 # heliodor_bracelet
# B196B1D3EDAE5F921C78030106
def heliodor_bracelet_weapon_code
  s_to_h('1C 78 03 01')
end

def heliodor_bracelet
  Regexp.new s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  1C 78 03 01 .. FF FF FF
    FF .. .. .. .. B9 18 01  0B 30 00 00 00 18 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 28 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

# B1 96 B1 D3 ED AE 5F 92 2D780301
# B196B1D3EDAE5F922D780301
def talisman
  s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  2D 78 03 01 06 FF FF FF
    FF 00 00 00 00 C7 18 01  0B 30 00 00 00 2D 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 50 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

# B1 96 B1 D3 ED AE 5F 92 26780301
# B196B1D3EDAE5F9226780301
def knights_anklet
  s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  26 78 03 01 06 FF FF FF
    FF 00 00 00 00 C1 18 01  0B 30 00 00 00 24 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 46 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

# 36 78 03 01
# B1 96 B1 D3 ED AE 5F 92 36780301
# B196B1D3EDAE5F9236780301
def oracle_card
  s_to_h(<<-S)
    B1 96 B1 D3 ED AE 5F 92  36 78 03 01 06 FF FF FF
    FF 00 00 00 00 CF 18 01  0B 30 00 00 00 38 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
    43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
    C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 46 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
    00
  S
end

require_relative '../lib/ruby_hex'
class ParseAccessories
  include Hex
  include SaveWizard
  include InventorySection

  def validate_item_id item_id
    raise 'Item id should be 4 bytes (len 8)' unless item_id.gsub(' ', '').length == 8
    item_id
  end

  def item_for_id item_id
    validate_item_id(item_id)
    "B1 96 B1 D3 ED AE 5F 92 #{item_id}".gsub(' ', '')
  end

  # replaced with accessory body
  def full_item_for_id item_id
    validate_item_id(item_id)

    s_to_h(<<-S)
      B1 96 B1 D3 ED AE 5F 92  #{item_id}  06 FF FF FF
      FF 00 00 00 00 B9 18 01  0B 30 00 00 00 18 00 00
      00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
      00 02 00 00 00 02 00 00  00 99 32 C5 C4 CC 57 6D
      43 27 9E 00 01 FF FF FF  FF 99 32 C5 C4 CC 57 6D
      43 27 9E 00 01 FF FF FF  FF 01 00 00 00 99 32 C5
      C4 CC 57 6D 43 27 9E 00  01 FF FF FF FF 13 00 00
      00 28 00 00 00 00 00 00  00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
      00 00 00 00 00 00 00 00  00 00 00 00 00 01 00 00
      00
    S
  end

  def all_accessories
    AllItems.get.select {|_key, values| values[1] == ACCESSORIES}
  end

  # all weapons, including invalid
  def all_accessories_codes
    weapon_codes = []
    all_accessories.each do |hex_code, values|
      weapon_codes << hex_code
    end
    weapon_codes
  end

  def invalid_accessory_codes
    weapon_codes = []
    all_accessories.each do |hex_code, values|
      # values: [item_name, item_type, item_valid]
      weapon_codes << hex_code unless values.last
    end
    weapon_codes
  end

  def valid_accessory_codes
    weapon_codes = []
    all_accessories.each do |hex_code, values|
      # values: [item_name, item_type, item_valid]
      weapon_codes << hex_code if values.last
    end
    weapon_codes
  end

  def find_known_accessories
    save = save_for_slot 2
    save_hex = bin_file_to_hex save

    weapons = all_accessories

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

  def save_for_slot slot_num
    "C:\\Users\\surface\\AppData\\Local\\Temp\\SWPS4MAX\\__gameplay____slot#{slot_num}__gameplay0.save"
  end

  def run
    slots = [2, 3, 4, 5]
    slots.each do |slot|
      puts "Slot #{slot}"
      save = save_for_slot slot

      save_hex = bin_file_to_hex save

      titanium_bangle_count = save_hex.scan(titanium_bangle).length
      puts "Titanium bangle x#{titanium_bangle_count}" if titanium_bangle_count > 0

      heliodor_bracelet_count = save_hex.scan(heliodor_bracelet).length
      puts "Heliodor bracelet x#{heliodor_bracelet_count}" if heliodor_bracelet_count > 0
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

  def replace_all_accessories(save_file_path, item_id)
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
      weapon_id = weapon_id.gsub(' ', '')[0...4*2] # use first four bytes
      target_save = "C:\\Users\\surface\\code\\ruby_hex\\workspace\\compare_weapons\\override\\__gameplay____slot#{start_index}__gameplay0.save"
      replace_all_accessories(target_save, weapon_id)
      start_index += 1
    end
  end

  def debug_accessory_ids(opts={})
    # divide all weapons into chunks up to size 30 (max sequential count of 496)
    # start counting at 2 since some items will be at x1
    # make sure < 500 item limit observed with apoc. after that items may not show up
    # (2..30).to_a.inject(0, :+) # 464  ... need 5x 99 accessories
    invalid_options = opts.keys - %i[chunk_max_size all_accessory_codes]
    raise "Invalid options: #{invalid_options.join(', ')}" unless invalid_options.empty?
    chunk_size = 1
    chunk_max_size = opts.fetch(:chunk_max_size, 29)
    weapon_codes = opts.fetch(:all_accessory_codes, all_accessories_codes)

    accessory_chunks = []
    tmp_chunk = []

    weapon_codes.each do |weapon_code|
      chunk_size += 1

      tmp_chunk << weapon_code

      if chunk_size > chunk_max_size
        chunk_size = 1
        accessory_chunks << tmp_chunk
        tmp_chunk = []
      end
    end

    accessory_chunks << tmp_chunk

    accessory_count = accessory_chunks.map {|e| e.uniq.length}
    puts "Accessory count: #{accessory_count} (#{accessory_count.inject(0, :+)})" # not 200 when using only invalid weapons
    # raise 'Weapon count is not 200' unless accessory_count.reduce(0, &:+) == 200

    # use slots 2 - 9
    raise 'Chunk size exceeds slot count' unless accessory_chunks.length <= 8
    accessory_chunks.each_with_index do |chunk_array, index|
      count_offset = 2 # start at 2.
      slot_num = index + 2
      target_save = "C:\\Users\\surface\\AppData\\Local\\Temp\\SWPS4MAX\\__gameplay____slot#{slot_num}__gameplay0.save"
      raise "Target save doesn't exist" unless File.exist?(target_save)
      save_hex = bin_file_to_hex target_save
      save_hex_before_length = save_hex.length

      # 5x 99 accessories to remain within default 464 items per slot (via chunk size)
      errors = []
      item_trim = 0..16*2
      filler_codes = [titanium_bangle, heliodor_bracelet, talisman, knights_anklet, oracle_card].map { |e| e[item_trim]}
      filler_codes_ids = filler_codes.map { |item| item[16...16+8]}
      filler_codes.each_with_index do |filler, index|
        found_length = save_hex.scan(filler).length
        errors << "slot: #{slot_num} index: #{index} count: #{found_length} != 99" unless found_length == 99
      end
      raise errors.join("\n") unless errors.empty?


      puts "Slot ##{slot_num} [#{slot_num + 1}]"

      weapons_to_check = []

      chunk_array.each do |weapon_code|
        next if filler_codes_ids.include?(weapon_code)
        puts "#{pretty_hex(weapon_code)} x#{count_offset}"
        # for count_offset times, add the weapon code

        full_item = full_item_for_id(weapon_code)[item_trim]

        current_gsubs = -1
        new_item = full_item
        weapons_to_check << [new_item, count_offset]
        item_count = 0

        # only gsub if it's followed by another item. otherwise the game will crash
        save_hex = save_hex.gsub(/#{filler_codes.join('|')}/x) do |match|
          # avoid subbing the same item over and over again.
          current_gsubs += 1

          if item_count < count_offset
            item_count += 1
            # puts "#{pretty_hex(new_item[16...16+8])} <- #{pretty_hex(match[16...16+8])}"
            new_item
          else
            match
          end
        end
        raise 'sub failed' if save_hex == nil

        found_length = save_hex.scan(full_item).length
        insert_successful = found_length == count_offset
        unless insert_successful
          raise "Inserted item count not found: #{weapon_code} x#{count_offset} != x#{found_length}"
        end

        count_offset += 1
      end

      # check all inserted weapons actually exist instead of just the last inserted item.
      weapons_to_check.each do |weapon_id, accessory_count|
        found_length = save_hex.scan(weapon_id).length
        insert_successful = found_length == accessory_count
        raise "Inserted item count not found: #{weapon_id[16..8+16]} x#{found_length} != x#{accessory_count}" unless insert_successful
      end

      raise 'Save corrupted' unless save_hex_before_length == save_hex.length

      hex_to_bin_file(target_save, save_hex)

      puts
    end
  end

  # 99x Titanium Bangle (+200 HP)
  # 99x Heliodor Bracelet (+40 STR)

  # add all accessories by replacing titanium bangle / heliodor bracelet
  # all_items = including debug
  def save_wizard(slot, opts = {})
    all_items = opts.fetch(:all_items, true)

    accessories_array = all_items ? all_accessories_codes : valid_accessory_codes

    save_wizard_target_slot = slot
    save_hex = bin_file_to_hex save_wizard_target_slot
    save_hex_before_length = save_hex.length

    titanium_bangle_count = save_hex.scan(titanium_bangle).length
    puts "Titanium Bangle x#{titanium_bangle_count}"
    raise 'titanium_bangle_count must be > 90' unless titanium_bangle_count > 90

    heliodor_bracelet_count = save_hex.scan(heliodor_bracelet).length
    puts "Heliodor Bracelet x#{heliodor_bracelet_count}"
    raise 'heliodor_bracelet_count must be > 90' unless heliodor_bracelet_count > 90

    accessory_codes_length = accessories_array.length
    puts "Total accessory codes: #{accessory_codes_length}"
    accessory_index = -1

    # gsub direct without matching on next item prefix. works because we know the full content of the item.
    dummy_accessories = [titanium_bangle, heliodor_bracelet]

    accessory_count = 0
    dummy_accessories.each do |dummy_weapon|
      save_hex.gsub!(dummy_weapon) do |match|
        accessory_index += 1
        valid_index = accessory_index < accessory_codes_length
        if valid_index
          accessory_count += 1
          item_id = accessories_array[accessory_index]
          full_item_for_id(item_id)
        else
          match
        end
      end
    end
    raise 'Save corrupted' unless save_hex_before_length == save_hex.length

    accessories_array.each do |accessory_code|
      # the dummy items will be gone because we gsubed all of them.
      next if [titanium_bangle_weapon_code, heliodor_bracelet_weapon_code].include?(accessory_code)
      puts "Missing accessory: #{accessory_code}" unless save_hex.scan(full_item_for_id(accessory_code)).length > 0
    end

    puts "Added #{accessory_count}x accessories"

    hex_to_bin_file(save_wizard_target_slot, save_hex)
  end
end # class ParseAccessories
