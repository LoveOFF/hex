require_relative 'parse_weapons'

parse_weapons = ParseWeapons.new

parse_weapons.save_wizard SaveWizard::SLOT_2, all_items: false
parse_weapons.save_wizard SaveWizard::SLOT_3, all_items: true
