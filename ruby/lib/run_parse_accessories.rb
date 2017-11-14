require_relative 'parse_accessories'

# ParseAccessories.new.debug_accessory_ids

parse_accessories = ParseAccessories.new

parse_accessories.save_wizard SaveWizard::SLOT_2, all_items: false
parse_accessories.save_wizard SaveWizard::SLOT_3, all_items: true
