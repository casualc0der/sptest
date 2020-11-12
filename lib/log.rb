# frozen_string_literal: true

require_relative 'logline_factory'

class Log
  attr_reader :data, :options, :choice

  def initialize(raw_data)
    @raw_data = raw_data
    @data = []
    @choice = false
  end

  def option(opts)
    total = %w[t T]
    unique = %w[u U]
    @choice = :total if total.include?(opts)
    @choice = :unique if unique.include?(opts)
  end

  def open
    raise 'Please supply valid file' if File.size(@raw_data).zero?

    File.read(@raw_data)
  end

  def format
    raise 'Please supply file in correct format' unless validation?

    format_lines(open)
  end

  def generate
    format.each do |logline|
      log = log_finder(logline)
      add_new_logline(logline) if log.nil?
      log&.add_ip(logline[1])
    end
    @data
  end

  private

  def validation?
    open.split("\n").all? { |line| format_checker(line) }
  end

  def format_checker(line)
    /.+ (\d{3}\.){3}\d{3}$/.match?(line)
  end

  def format_lines(line)
    line.split("\n").map { |line| line.split(' ') }
  end

  def log_finder(logline)
    data.find { |l| l.path == logline[0] }
  end

  def add_new_logline(logline)
    logger = LogLineFactory.create_logline(@choice, logline[0])
    logger.add_ip(logline[1])
    data << logger
  end
end
