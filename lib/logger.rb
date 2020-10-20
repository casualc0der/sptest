require_relative 'log'
require_relative 'parser'




while true
puts 'Return total (t) or unique (u) visits? please enter t or u:'



log = Log.new(ARGV[0])

options = "t"
parser = Parser.new(options)
parser.report(log.generate)
end