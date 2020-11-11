# frozen_string_literal: true

class LogLine
  attr_reader :path, :ip_addresses
  def initialize(path)
    @path = path
    @ip_addresses = []
  end

  def add_ip(ip)
    @ip_addresses << ip
  end

  def report
  end

end
