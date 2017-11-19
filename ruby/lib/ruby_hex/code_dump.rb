# Parses all item ids from the save file
# Save file includes a list of all valid item ids, even those not currently obtained
class CodeDump
  include Hex
  include InventorySection

  # Item ID from save file (not in inventory):
  # BA 89 98 AA F0 F4 89 A6 [0E A5 03 01]

  # Item in inventory:
  # D8 A2 61 2D 78 20 C8 3E [0E A5 03 01]
  def initialize(save)
    @save = save
  end

  def item_id_prefix
    'BA 89 98 AA F0 F4 89 A6'.gsub(' ', '')
  end

  def item_id_pattern
    # BA 89 98 AA F0 F4 89 A6 03 31 00 01 03
    # BA 89 98 AA F0 F4 89 A6 74 50 00 01 03
    #                         74 50 00 01 - item code
    #                                     03 - unknown
    /BA 89 98 AA F0 F4 89 A6 .. .. .. .. ../x
  end

  def run
    hex_str = bin_file_to_hex(@save)
    scanner = StringScanner.new(hex_str)

    codes = []
    last_match_pos = 0
    section_index = 0
    first_match = true
    item_index = 0

    known_codes_csv = AllItems.csv
    section_counts = Hash.new 0

    while scanner.scan_until(item_id_pattern)
      # scan_until advances *past* the match. must backtrack to recover the matched segment
      # BA8998AAF0F489A60331000103BA8998AAF0F489A67450000103
      #                           ^
      #                           scan pointer is here
      # jump back 10: 0331000103
      # take 8: 03310001
      current_match_pos = scanner.pos - 10
      item_code = hex_str[current_match_pos, 8]

      if current_match_pos - last_match_pos != 26 && !first_match
        section_index += 1
        item_index = 0
      end

      last_match_pos = current_match_pos
      first_match = false

      next if item_code == '0' * 8
      next if item_code == 'F' * 8

      raise "Invalid hex code: #{item_code}" unless item_code.match(/^\h{8}$/)

      current_code = nil
      current_section = section_name(section_index)
      section_counts[current_section] += 1
      # csv format:
      # [0]   [1]   [2]   [3]    [4]  [5]   [6]     [7]     [8]
      # Code  Type  Name  Index  Valid  Blank  No Icon  No Desc  Notes
      known_codes_csv.each do |row|
        if item_code == row[0]
          row['Type'] = current_section
          row['Index'] = item_index
          current_code = row.to_csv(col_sep: "\t").chomp
          break
        end
      end

      unless current_code
        current_code = "#{item_code}\t#{current_section}\t\t#{item_index}"
      end

      codes << current_code
      item_index += 1
    end

    puts "Total item counts per section"
    puts "Section\tTotal"
    section_counts.each { |k,v | puts "#{k}\t#{v}"}

    codes
  end
end # class InventoryParse
