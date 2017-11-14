class AllItems

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

  def self.csv
    return @csv if @csv
    csv_name = 'all_codes.csv'

    base = join(__dir__, '../../../workspace/treasure_ids')
    codes = join(base, csv_name)
    @csv = CSV.readlines(codes, headers: true)
  end

  def self.get
    return @codes if @codes
    # 'all_codes' tab
    # https://docs.google.com/spreadsheets/d/1abSI4OUYEv6bCMll4PDNQikxPikoS9lLUt8TP8JUpX0/edit#gid=649850122
    csv = self.csv
    codes = {}

    csv.each do |row|
      # [0]   [1]   [2]   [3]    [4]  [5]   [6]     [7]     [8]
      # Code  Type  Name  Index  Valid  Blank  No Icon  No Desc  Notes

      unknown_name = 'Unknown'

      hex_code = row[0].strip.upcase
      raise "Invalid hex code: #{hex_code}" unless hex_code.match(/^\h{8}$/)

      item_type = (row[1] || unknown_name).strip
      item_name = (row[2] || unknown_name).strip
      item_valid = row[4]&.downcase&.strip&.include?('x')

      codes[hex_code] = [item_name, item_type, item_valid]
    end

    @codes = codes
  end
end
