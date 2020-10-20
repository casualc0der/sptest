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

  def report_total_visits
    @ip_addresses.length
  end

  def report_unique_visits
    @ip_addresses.uniq.length
  end
end
