require_relative 'logline'
class Log
  attr_reader :data
  def initialize(raw_data)
    @raw_data = raw_data
    @data = []
  end

  def open
    raise "Please supply valid file" if File.size(@raw_data).zero?
    File.read(@raw_data)
  end
  def format
    raise "Please supply file in correct format" unless validation?
    format_lines(open)
  end
  def generate
    format.each do |logline|
      x = data.find { |l| l.path == logline[0] }
      if x.nil?
        logger = LogLine.new(logline[0])
        logger.add_ip(logline[1])
        data << logger
      else
        x.add_ip(logline[1])
      end
    end
    @data
  end
  private
  def validation?
    open.split("\n").all? {|line| format_checker(line)}
  end
  def format_checker(line)
    /\/.+ (\d{3}\.){3}\d{3}/.match(line)
  end
  def format_lines(line)
    line.split("\n").map {|line| line.split(" ")}
  end
end