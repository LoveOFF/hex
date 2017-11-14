require_relative 'ruby_hex'

# used from `def o`
def print_table array
  result = StringIO.new
  all_max_len = array.map(&:length).max
  all_array_count = array.length

  all_max_len.times do |line_index|
    all_array_count.times do |array_index|
      result.print (array[array_index][line_index] || ' ') + "\t"
    end
    result.puts
  end

  result.string
end

# set debug flag to print codes to stdout instead of writing to file
def o(array, debug: false)
  all_arrays = []
  valid_arrays = []

  array.each do |sub_array|
    all_arrays << sub_array[0]
    valid_arrays << sub_array[1]
  end

  all_table = print_table all_arrays.inject([], :concat)
  debug ? puts(all_table) : File.write('all_table.txt', all_table)

  valid_table = print_table valid_arrays.inject([], :concat)
  debug ? puts(valid_table) : File.write('valid_table.txt', valid_table)
end

code_gen = CodeGen.new
code_gen.debug = true
code_gen.debug = false

# all_codes = [code_gen.battle_items,
#              code_gen.key_items,
#              code_gen.ingredients,
#              code_gen.treasures,
#              code_gen.car_parts,
#              code_gen.leisure_items]

all_codes = [code_gen.weapons,
            code_gen.accessories]

o all_codes
# lines of code
puts "all codes: #{all_codes.flatten.length}"

# o [code_gen.weapons,
#    code_gen.accessories]

# one off code to reset the first 14 magic flasks
#
# code_gen.reset_magic_code
