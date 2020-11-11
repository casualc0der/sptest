
require_relative 'unique_logline'
require_relative 'total_logline'
class LogLineFactory

  def self.create_logline(choice, path)
    return UniqueLogline.new(path) if choice == :unique
    return TotalLogline.new(path) if choice == :total
  end

end
