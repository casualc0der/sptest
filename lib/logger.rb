# frozen_string_literal: true

require_relative 'log'
require_relative 'parser'
class Logger
  def self.run
    while true
      puts 'Return total (t) or unique (u) visits? please enter t or u:'
      log = Log.new(ARGV[0])
      options = $stdin.gets.chomp
      parser = Parser.new(options)
      break unless parser.choice == false
    end

    puts parser.report(log.generate)
  end
end
