# frozen_string_literal: true

require_relative 'log'
require_relative 'parser'
class Logger
  def self.run
    abort "USAGE: ruby bin/logger 'path/to/file'" if ARGV[0].nil?
    while true
      puts 'Return total (t) or unique (u) visits? please enter t or u:'
      log = Log.new(ARGV[0])
      options = $stdin.gets.chomp
      log.option(options)
      parser = Parser.new

      break unless log.choice == false
    end

    puts parser.report(log.generate)
  end
end
