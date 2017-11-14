module Hex
  def hex_to_bin hex_str
    hex_str = hex_str.gsub(/\s+/, '')
    raise 'Invalid hex string' unless hex_str =~ /^\h+$/
    raise 'Incomplete hex string' unless hex_str.length % 2 == 0
    Array(hex_str).pack('H*')
  end

  def str_to_hex(str, pretty: false)
    hex = str.unpack('H*').first.upcase
    return hex unless pretty
    pretty_hex(hex)
  end

  # 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00

  def bin_to_hex(hex_bin, pretty: false)
    hex = hex_bin.unpack('H*').first.upcase
    return hex unless pretty

   pretty_hex(hex)
  end

  def pretty_hex hex_str
    count = 0
    hex_str.gsub(/(..)/) do |result|
      if count == 7
        result += ' ' * 2
        count += 1
      elsif count == 15
        result += "\n"
        count = 0
      else
        result += ' '
        count += 1
      end

      result
    end.rstrip.upcase
  end

  def zero_pad_int(value, pad_length)
    hex_value = value.to_s(16).upcase
    '0' * (pad_length - hex_value.length) + hex_value
  end

  def bin_file_to_hex(bin_file, pretty: false)
    raise "bin file doesn't exist: #{bin_file}" unless File.exist?(bin_file)
    bin_to_hex(File.binread(bin_file), pretty: pretty)
  end

  def hex_to_bin_file(bin_file, hex_str)
    File.binwrite(bin_file, hex_to_bin(hex_str))
  end

  # convert little edian to big endian
  def reverse_hex(hex_str)
    hex_str.scan(/.{2}/).reverse.join('')
  end
end
