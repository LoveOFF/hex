require_relative '../ruby_hex'

class Main
  include Hex
  include Flask

  def run
    # todo: magic flask set to 999 ? (similar to oracle ascention coin)
    save = gameplay_slot_2
    stopwatch = Stopwatch.new.start

    puts "Reading save: #{save}"
    hex_str = bin_file_to_hex(save)
    before_length = hex_str.length

    puts 'before empty flasks: ' + hex_str.scan(/#{empty_flask_pattern}/).length.to_s

    # Replace empty flasks with flare/electron/freeze limit break
    # gsub all ~524 matches (!!)
    count = -1
    hex_str.gsub!(empty_flask_pattern) do
      count += 1
      count = 0 if count > 2
      case count
        when 0
          flare_flask_pattern
        when 1
          electron_flask_pattern
        when 2
          freeze_flask_pattern
        else
          raise "Invalid count: #{count}"
      end
    end

    after_length = hex_str.length
    raise 'Data corrupted' unless before_length == after_length
    hex_to_bin_file(gameplay_slot_2, hex_str)

    puts 'after empty flasks: ' + hex_str.scan(/#{empty_flask_pattern}/).length.to_s
    puts 'after flare flasks: ' + hex_str.scan(/#{flare_flask_pattern}/).length.to_s
    puts 'after elect flasks: ' + hex_str.scan(/#{electron_flask_pattern}/).length.to_s
    puts 'after freez flasks: ' + hex_str.scan(/#{freeze_flask_pattern}/).length.to_s

    puts "Finished reading save in #{stopwatch.stop}"
  end
end

Main.new.run
