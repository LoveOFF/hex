module InventorySection
  BATTLE_ITEMS = 'Battle Items [0]' # 64
  KEY_ITEMS = 'Key Items [1]' # 207
  INGREDIENTS = 'Ingredients [2]' # 118
  TREASURES = 'Treasures [3]' # 256
  CAR_PARTS = 'Car Parts [4]' # 220
  LEISURE = 'Leisure Items [5]' # 159
  MAGIC_BOTTLE = 'Magic Bottle [8]'
  WEAPONS = 'Weapons [10]'
  ACCESSORIES = 'Accessories [12]'
  UNKNOWN = 'Unknown'

  # don't auto process: magic bottle/weapons/accessories since the format for that is different.
  def valid_type? item_type
    [BATTLE_ITEMS, KEY_ITEMS, INGREDIENTS, TREASURES, CAR_PARTS, LEISURE].include?(item_type)
  end

  def section_name section_index
    case section_index
      when 0
        BATTLE_ITEMS # information_battle_item
      when 1
        KEY_ITEMS # information_event_item
      when 2
        INGREDIENTS # information_food_item
      when 3
        TREASURES # information_treasure_item
      when 4
        CAR_PARTS # information_car_item
      when 5
        LEISURE # information_leisure_item
      when 7 # 6 doesn't exist.
        'Reinforcement Items [7]' # information_reinforcement_item
      when 8
        MAGIC_BOTTLE # information_magic_bottle
      when 9
        'Ring [9]' # information_ring_amount
      when 10
        WEAPONS # information_weapon
      when 11
        'Phantom Swords [11]' # information_phantom_sword
      when 12
        ACCESSORIES # information_accessory
      when 13
        'Cloth [13]' # information_accessory
      when 14
        'Job Commands [14]' # information_job_command
      when 15
        'Recipe [15]' # information_recipe
      else
        'Unknown' + " [#{section_index}]"
    end
  end
end
