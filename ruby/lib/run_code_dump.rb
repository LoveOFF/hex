require_relative 'ruby_hex'

class RunParser
  include Hex

  def initialize
    @base = join(__dir__, '../workspace/treasure_ids')
    @save = join(@base, '10.1.2017_v1.16.save')

    # @save = 'C:\Users\surface\AppData\Local\Temp\SWPS4MAX\__gameplay____slot2__gameplay0.save'
  end

  def run
    codes = CodeDump.new(@save).run
    File.write('codes.txt', codes.join("\n"))
  end
end
# Code,	Type,	Name,	Index,	Valid,	Blank,	No Icon,	No Desc,	Notes
RunParser.new.run

