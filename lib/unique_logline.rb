require_relative 'logline'
class UniqueLogline < LogLine
  def initialize(path)
    super
  end

  def report
    @ip_addresses.select { |address| @ip_addresses.count(address) < 2 }.length
  end
end
