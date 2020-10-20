require_relative 'log'
require_relative 'parser'



puts 'Return total (t) or unique (u) visits? please enter t or u:'



log = Log.new(ARGV[0])

options = "t"
parser = Parser.new(options)
puts parser.report(log.generate)