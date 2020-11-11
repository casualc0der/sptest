require_relative 'logline'
class TotalLogline < LogLine
  def initialize(path)
    super
  end

  def report
    @ip_addresses.length
  end
end
