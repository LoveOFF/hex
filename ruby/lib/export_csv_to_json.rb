require_relative 'ruby_hex'
require 'json'

class ExportCsvToJson
  include Hex

  def run


    # must lower case for javascript

    File.write('codes.json', 'export let codes = ' + ::JSON.pretty_generate(AllItems.get(true)))
  end
end

ExportCsvToJson.new.run
