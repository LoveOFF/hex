class InventoryParse
  include Hex
  include InventorySection
  # Item ids cover a large search space (~65k) and are not sequential.

  def initialize(save)
    @save = save
  end

  # Marks start of *entire* inventory, not just treasures.
  def inventory_start_pattern
    # only 1 match in entire save file
    /B2 69 26 91 67 BC E2 44 40 00 00 00/x
  end

  # 1,616 items & 1 false positive at the end of file.
  # matches one at the end... must validate that this item is immediately after another matching item.
  # stops at flask region: 8A D2 D1 01 AF 89 E6 90
  def item_pattern
    /D8 A2 61 2D 78 20 C8 3E .. .. .. .. .. .. 00 00/x
    # D8 A2 61 2D 78 20 C8 3E [item code] [amount] 00 00
    # D8 A2 61 2D 78 20 C8 3E 00 00 00 00 00 00 00 00
    # D8 A2 61 2D 78 20 C8 3E 56 D3 04 01 63 00 00 00

    # may not always end with 8 bytes. sometimes it's 12.
    # D8 A2 61 2D 78 20 C8 3E 00 00 00 00 00 00 00 00 00 01 00 00

    # hex search: (set CC as wildcard)
    # 'D8 A2 61 2D 78 20 C8 3E .. .. .. .. .. .. .. ..'.gsub(' ', '').gsub('.', 'C')
    # D8A2612D7820C83ECCCCCCCCCCCCCCCC
  end

  def item_start_pattern
    /D8 A2 61 2D 78 20 C8 3E/x
  end

  def empty_item_code
    'D8 A2 61 2D 78 20 C8 3E  00 00 00 00 00 00 00 00'.gsub(' ', '')
  end

  def print(output_format:, debug: false)
    parsed_items = []
    all_item_codes = AllItems.get

    hex_str = bin_file_to_hex(@save)
    hex_str_length = hex_str.length

    scanner = StringScanner.new(hex_str)
    scanner.scan_until(inventory_start_pattern)

    raise "Invalid output #{output_format}" unless [:tsv, :csv, :string].include?(output_format)

    separator = case output_format
                  when :tsv
                    "\t"
                  when :csv
                    ','
                  else
                    nil
                end

    if %i[tsv csv].include?(output_format)
      headers = %w[Code = Reverse = Name Type Amount]
      parsed_items << headers.join(separator)
    end

    missing_codes = []

    section_index = 0
    item_count = 0
    while (raw_item_hex = scanner.scan(item_pattern))
      current_section = section_name(section_index)
      # D8 A2 61 2D 78 20 C8 3E 00 00 00 00 00 00 00 00
      #                         ^^ ^^ ^^ ^^ **

      item_scan = StringScanner.new(raw_item_hex)
      item_scan.scan(item_start_pattern)
      item_code = item_scan.scan(/\h{8}/)

      if item_code != '00000000'
        item_amount = item_scan.scan(/\h{4}/)

        found_item = all_item_codes[item_code]


        # 63 00  => 00 63
        # '6300'.hex = 25344 when it should be '0063'.hex = 99
        item_amount = reverse_hex(item_amount).hex
        missing_codes <<  "#{item_code} x#{item_amount} (#{current_section})" unless found_item

        unknown_item = 'Unknown'
        # all_item_codes = { code => [item_name, item_type], ... }
        item_name, item_type = all_item_codes[item_code]
        item_name ||= unknown_item
        item_type ||= unknown_item

        parsed_items << if %i[tsv csv].include?(output_format)
                          # Code, =, Reverse, =, Name, Type, Amount
                          [item_code, '=', reverse_hex(item_code), '=', item_name, item_type, item_amount].join(separator)
                        elsif :string == output_format
                          "#{item_name} x#{item_amount} (#{item_type}) [#{item_code}]"
                        end
      end

      item_count += 1

      # may not always end with 8 bytes. sometimes it's 12.
      # D8 A2 61 2D 78 20 C8 3E 00 00 00 00 00 00 00 00 00 01 00 00
      if (peek_8 = scanner.peek(8)) != 'D8 A2 61 2D'.gsub(' ', '')
        next_section = section_name(section_index+1)
        # break if next_section == UNKNOWN
        if debug
          section_debug_line = "section #{current_section} → #{next_section} [#{peek_8}] (#{section_index})"
          puts section_debug_line
          parsed_items << section_debug_line
        end

        # item categories extracted via strings
        #
        # 0
        # information_battle_item)
        # information_battle_item_amount
        #
        # 1
        # information_event_item)
        # information_event_item_amount
        #
        # 2
        # information_food_item)
        # information_food_item_amount
        #
        # 3
        # information_treasure_item)
        # information_treasure_item_amount
        #
        # 4
        # information_car_item)
        # information_car_item_amount
        #
        # 5
        # information_leisure_item)
        # information_leisure_item_amount
        #
        # 6
        # information_reinforcement_item)
        # information_reinforcement_item_amount
        #
        # 7
        # information_magic_bottle)
        # information_magic_bottle_amount
        # information_magic_bottle_available)
        # information_magic_bottle_available_amount
        #
        # 8
        # information_ring_amount
        #
        # 9
        # information_weapon)
        #
        # 10
        # information_phantom_sword)
        # information_phantom_sword_amount
        #
        # 11
        # information_accessory)
        # information_accessory_amount
        #
        # 12
        # information_cloth)
        # information_cloth_amount
        #
        # 13
        # information_job_command)
        # information_job_command_amount
        #
        # 14
        # information_recipe)
        # information_recipe_amount


        # 8 section dividers
        #
        # battle      [0]
        # event       [1]
        # ingredients [2]
        # treasures   [3]
        # car parts   [4]
        # leisure     [5]
        # unknown     [6]
        # unknown     [7]
        # unknown     [8]
        # section Battle Items → Event Items [00010000] - 0
        # section Event Items → Ingredients [00010000]  - 1
        # section Ingredients → Treasures [00010000]    - 2
        # section Treasures → Car Parts [00010000]      - 3
        # section Car Parts → Leisure Items [00010000]  - 4
        # section Leisure Items → Unknown [10000000]    - 5
        # section Unknown → Unknown [00010000]          - 6
        # section Unknown → Magic Flask [01000000 10000000] - 7
        scanner.pos += 8 # jump past '00 01 00 00'
        section_index += 1
      end
    end

    parsed_items << "Scanned: #{item_count} item slots" if debug

    raise 'save corrupted' unless hex_str_length == hex_str.length

    result = parsed_items.join("\n")

    unless missing_codes.empty?
      puts result
      raise "Missing codes!\n#{missing_codes.join("\n")}"
    end

    result
  end

  def print_slots
    hex_str = bin_file_to_hex(@save)
    hex_str_length = hex_str.length
    scanner = StringScanner.new(hex_str)
    scanner.scan_until(inventory_start_pattern)

    item_slots = {}
    section_index = 0
    while scanner.scan(item_pattern)
      current_section = section_name(section_index)
      item_slots[current_section] ||= 0
      item_slots[current_section] += 1

      # may not always end with 8 bytes. sometimes it's 12.
      # D8 A2 61 2D 78 20 C8 3E 00 00 00 00 00 00 00 00 00 01 00 00
      if (peek_8 = scanner.peek(8)) != 'D8 A2 61 2D'.gsub(' ', '')
        next_section = section_name(section_index+1)

        section_debug_line = "section #{current_section} → #{next_section} [#{peek_8}] (#{section_index})"
        puts section_debug_line

        scanner.pos += 8 # jump past '00 01 00 00'
        section_index += 1
      end
    end

    raise 'save corrupted' unless hex_str_length == hex_str.length
    puts 'Item slots:'
    item_slots.each do |key, value|
      puts "#{key} => #{value}"
    end

    item_slots
  end

  def valid_divider?(divider)
    section_divider = '00010000' # battle/event/ingredients/treasure/car_parts
    leisure_divider = '10000000' # leisure
    raise 'Invalid divider size' unless divider.length == divider_length
    [section_divider, leisure_divider].include?(divider)
  end

  def divider_length
    '00010000'.length
  end

  # in index mode, count up numbers for each section to easily identify broke codes.
  #
  # debug - print debug messages
  # all_items - add all item codes, including invalid
  # index - sequential item count for debugging
  def modify(index: false, debug: false, all_items: false)
    all_item_codes = AllItems.get

    hex_str = bin_file_to_hex(@save)
    hex_str_length = hex_str.length

    scanner = StringScanner.new(hex_str)
    scanner.scan_until(inventory_start_pattern)

    items_added = {}
    current_type = section_name(0)
    # assumes all_item_codes are in the natural section order: battle, event, ingredient, treasure, car, leisure
    all_item_codes.each do |code, name_type_valid|
      _item_name, item_type, valid_item = name_type_valid
      valid_item = true if all_items
      # only process: [BATTLE_ITEMS, KEY_ITEMS, INGREDIENTS, TREASURES, CAR_PARTS, LEISURE]
      # when not indexing items for debugging, include only known good items (not blank/no missing icons)
      next unless valid_type?(item_type)

      # type change requires a divider
      if current_type != item_type
        puts "#{current_type} -> #{item_type}"
        current_type = item_type

        until valid_divider?(scanner.peek(divider_length))
          # DO *NOT* insert dividers. Game will crash on load.
          # battle has 64 slots, event/ingredient/treasure/car/leisure is 256 slots

          # we've finished adding all items for a type but haven't reached a divider
          # add blank items until the divider is reached
          hex_str[scanner.pos, empty_item_code.length] = empty_item_code
          scanner.pos += empty_item_code.length
        end

        # advance past divider
        puts "Divider: #{scanner.peek(divider_length)}"
        scanner.pos += divider_length
      end

      next if index == false && !valid_item
      items_added[item_type] ||= 0
      items_added[item_type] += 1

      amount = 'FFF0' # use slightly less than max of FFFF to prevent overflows
      #'6300' = 99

      if index
        amount = items_added[item_type].to_s(16) # int -> hex
        # now zero pad
        amount = '0' * (4 - amount.length) + amount
        amount = reverse_hex(amount) # reverse before storing in save file
      end

      raise "invalid amount: #{amount}" unless amount.length == 4

      # add item from code list
      new_item_hex = "D8A2612D7820C83E#{code}#{amount}0000"
      raise 'Invalid item' unless new_item_hex.length == 32
      hex_str[scanner.pos, new_item_hex.length] = new_item_hex
      scanner.pos += new_item_hex.length

    end

    puts "Items added: #{items_added}"
    raise 'Exceeded Battle items limit' unless items_added[BATTLE_ITEMS] <= 64
    raise 'Exceeded Key items limit' unless items_added[KEY_ITEMS] <= 256
    raise 'Exceeded Ingredients limit' unless items_added[INGREDIENTS] <= 256
    raise 'Exceeded Treasures limit' unless items_added[TREASURES] <= 256
    raise 'Exceeded Car parts limit' unless items_added[CAR_PARTS] <= 256
    raise 'Exceeded Leisure items limit' unless items_added[LEISURE] <= 256

    raise 'save corrupted' unless hex_str_length == hex_str.length

    hex_str
  end

  # def run(..)

  def modify_and_save(*args)
    hex_str = modify(*args)
    hex_to_bin_file(@save, hex_str)
  end
end # class InventoryParse
