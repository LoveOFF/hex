module Flask
  def base_folder
    'C:\Users\surface\AppData\Local\Temp\SWPS4MAX'
  end

  def gameplay_slot_2
    join(base_folder, '__gameplay____slot2__gameplay0.save')
  end

  def freeze_flask_pattern
    # spell id: 9C 80 03 01
    '8AD2D101AF89E6909C8003016300000000FFFFFFFFFFFFFFFFC42F010BC32F010B0A000000BF8103010F2700009C31030163000000'
  end

  def electron_flask_pattern
    # spell id: C5 80 03 01
    '8AD2D101AF89E690C58003016300000000FFFFFFFFFFFFFFFFE32A010B0B2C010B0B000000EA8103010F2700009C31030163000000'
  end

  def flare_flask_pattern
    # spell id:     73 80 03 01 -- Flare
    # spell amount: 63
    # magic:        92 81 03 01 -- Flare
    # potency:      0F 27
    # effect:       9C 31 03 01 -- Limit Break
    # level:        63
    #
    # 8B 2A 01 0B B3 2B 01 0B 09 icon code?? when omitted there's no icon or limit break.

    (<<-STR).gsub(/\n*\s*/, '')
      8A D2 D1 01 AF 89 E6 90  73 80 03 01 63 00 00 00
      00 FF FF FF FF FF FF FF  FF 8B 2A 01 0B B3 2B 01
      0B 09 00 00 00 92 81 03  01 0F 27 00 00 9C 31 03
      01 63 00 00 00
    STR
  end

  def empty_flask_pattern
    # 00 8A D2 D1 01 AF 89 E6  90 -- header
    # 8AD2D101AF89E690
    # . matches any file

    # pattern matching across a line break... not good
    # need to match on one contiguous string
    # use pretty: false to avoid spaces breaking the matching

    # E6 6C 01 01 - code for empty flask

    (<<-STR).gsub(/\n*\s*/, '')
    8A D2 D1 01 AF 89 E6 90  E6 6C 01 01 00 00 00 00
    00 FF FF FF FF FF FF FF  FF 00 00 00 00 00 00 00
    00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
    00 00 00 00 00
    STR
  end
end

=begin

8A D2 D1 01 AF 89 E6 90  90 AB 03 01 00 00 00 00
00 FF FF FF FF FF FF FF  FF 00 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 01 00 00 00 89 31 03
01 00 00 00 00

                           /-- offset 8
                         [8]
8A D2 D1 01 AF 89 E6 90  90 E6 6C 01 01 00 00 00
00 00 FF FF FF FF FF FF  FF FF 00 00 00 00 00 00
00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
00 00 00 00 00 00 D2 D1  01 AF


reset 14 flasks code

search for "8A D2 D1 01 AF 89 E6 90"

write 44 bytes in reverse order starting at offset 9


    E6 6C 01 01
    00 00 00 00
    00 FF FF FF
    FF FF FF FF
    FF 00 00 00
    00 00 00 00
    00 00 00 00
    00 00 00 00
    00 00 00 00
    00 00 00 00
    00 00 00 00
    00


80010008 8AD2D101
AF89E690 00000000

search (8) one time (001) and match 8 bytes (0008) for the value "8A D2 D1 01 AF 89 E6 90". Each hex pair is a byte.

--

start at offset 8 (offsets are zero indexed)
 (0..11).each { |e| puts( (0x8 + (0x4*e)).to_s(16).upcase) }

28000008 01016CE6 [0]
2800000C 00000000 [1]
28000010 FFFFFF00 [2]
28000014 FFFFFFFF [3]
28000018 000000FF [4]
2800001C 00000000 [5]
28000020 00000000 [6]
28000024 00000000 [7]
28000028 00000000 [8]
2800002C 00000000 [9]
28000030 00000000 [10]
08000034 00000000 [11]


32-bit write (2) offset from pointer (8) using offset 9 (000009) write "E6 6C 01 01".
write contents are reversed due to big edian vs little edian.


01016CE6       [0]
00 00 00 00    [1]
FFFFFF00       [2]
FFFFFFFF       [3]
000000FF       [4]
00 00 00 00    [5]
00 00 00 00    [6]
00 00 00 00    [7]
00 00 00 00    [8]
00 00 00 00    [9]
00 00 00 00   [10]
00            [11]

~~~~~~~~~~~~


search (8) one time (001) and match 8 bytes (0008) for the value "8A D2 D1 01 AF 89 E6 90". Each hex pair is a byte.

80010008 8AD2D101
AF89E690 00000000
28000009 01016CE6
2800000D 00000000
28000011 FFFFFF00
28000015 FFFFFFFF
28000019 000000FF
2800001D 00000000
28000021 00000000
28000025 00000000
28000029 00000000
2800002D 00000000
28000031 00000000
08000035 00000000

=end
