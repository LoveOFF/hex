require_relative 'ruby_hex'

class RunParser
  include Hex

  def initialize
    @base = join(__dir__, '../workspace/treasure_ids')
    # @save = join(@base, '__gameplay____slot2__gameplay0.save')
    @save_maxed = join(@base, 'maxed.save')
  end

  def save_wizard(slot, opts={})
    # game crashes on loading a corrupt save file.
    save_wizard_parser = InventoryParse.new(slot)

    save_wizard_parser.modify_and_save(opts)

    # save_wizard_parser.modify_and_save(all_items: true) # all items including debug
    # save_wizard_parser.modify_and_save(all_items: false) # all valid items


    # save_wizard_parser.modify_and_save(index: true) # for debugging
    # save_wizard_parser.modify_and_save(index: false) # max valid items
    # save_wizard_parser.modify_and_save(all_items: true, index: true) # all items with debug index
    # puts save_wizard_parser.print(output_format: :string)
    # puts save_wizard_parser.print_slots
  end

  def print_slot slot
    output =  InventoryParse.new(slot).print(output_format: :string)
    puts output
    puts 'unknowns found !!' if output.include? 'Unknown'
  end
end

# RunParser.new.save_wizard SaveWizard::SLOT_2, all_items: false
# RunParser.new.save_wizard SaveWizard::SLOT_3, all_items: true
#
# RunParser.new.print_slot(SaveWizard::SLOT_2)


RunParser.new.save_wizard SaveWizard::SLOT_2, all_items: true


=begin
Section boundary logic is incredibly broken


end of leisure:

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

0026D810   D8 A2 61 2D 78 20 C8 3E  00 00 00 00 00 00 00 00
0026D820   10 00 00 00 D8 A2 61 2D  78 20 C8 3E 00 00 00 00
0026D830   00 00 00 00

empty item code: D8 A2 61 2D 78 20 C8 3E  00 00 00 00 00 00 00 00
followed by: 10 00 00 00

# D8A2612D7820C83E78B6050163 00000000010000 D8A2612D7820C83E90AB0301

-----

Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

0026E910                            D8 A2 61 2D 78 20 C8 3E
0026E920   00 00 00 00 00 00 00 00  01 00 00 00 10 00 00 00
0026E930   8A D2 D1 01 AF 89 E6 90  90 AB 03 01

blank item code:
D8 A2 61 2D 78 20 C8 3E 00 00 00 00 00 00 00 00

end inventory code, start of flasks:
01 00 00 00 10 00 00 00

start unknown:
8A D2 D1 01 AF 89 E6 90  [90 AB 03 01]


after Liesure Items (10000000) ... still a bunch of leisure items


Reached section boundary before adding all Battle Items items. Added 63. Remaining: 1
Reached section boundary before adding all Event Items items. Added 47. Remaining: 160
Reached section boundary before adding all Ingredients items. Added 17. Remaining: 101
Reached section boundary before adding all Treasures items. Added 255. Remaining: 1
Reached section boundary before adding all Car Parts items. Added 34. Remaining: 186
Reached section boundary before adding all Leisure Items items. Added 95. Remaining: 64

=end
