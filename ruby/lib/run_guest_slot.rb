require_relative 'ruby_hex'

class GuestSlot
  include Hex
  include InventorySection
  include SaveWizard

=begin
Ardyn
0B E9 99 E5 5D 01 01 FF FF FF FF 03 01 00 00 00
0B E9 99 E5 5D 01 01 04 00 00 00 03 00 00 00 00

3F 89 CF A5 62 FF FF FF FF 06 00 00 00 F1 23 ED
3F 89 CF A5 62 04 00 00 00 06 00 00 00 F1 23 ED
=end

  def ardyn_id
    Regexp.new /0B E9 99 E5 5D 01 01 .. .. .. .. .. .. 00 00 00/x
  end

  def ardyn_id_in_party
    '0B E9 99 E5 5D 01 01 04 00 00 00 03 00 00 00 00'.gsub(' ', '')
  end

  def guest_slot
    Regexp.new /3F 89 CF A5 62 .. .. .. .. 06 00 00 00 F1 23 ED/x
  end

  def ardyn_guest_slot
    '3F 89 CF A5 62 04 00 00 00 06 00 00 00 F1 23 ED'.gsub(' ', '')
  end

  def save_wizard
    puts 'Adding Ardyn to party'
    save_wizard_target_slot = SLOT_2
    save_hex = bin_file_to_hex save_wizard_target_slot
    save_hex_before_length = save_hex.length

    gsub_matches = 0
    save_hex.gsub!(ardyn_id) { gsub_matches += 1; ardyn_id_in_party }
    raise "Matched #{gsub_matches}. Expected 1" unless gsub_matches == 1

    # add ardyn
    gsub_matches = 0
    save_hex.gsub!(guest_slot) { gsub_matches += 1; ardyn_guest_slot}

    raise "Matched #{gsub_matches}. Expected 1" unless gsub_matches == 1

    raise 'Save corrupted' unless save_hex_before_length == save_hex.length
    hex_to_bin_file(save_wizard_target_slot, save_hex)
  end
end

GuestSlot.new.save_wizard
