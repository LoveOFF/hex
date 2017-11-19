require_relative 'ruby_hex'

class RunParser
  include Hex

  def run
    save = SaveWizard::SLOT_2
    save = '../workspace/v1.18.save'
    codes = CodeDump.new(save).run
    File.write('codes.txt', codes.join("\n"))
  end
end

# Code,	Type,	Name,	Index,	Valid,	Blank,	No Icon,	No Desc,	Notes
RunParser.new.run
