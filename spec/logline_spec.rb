class LogLine
  attr_reader :path, :ip_addresses
  def initialize(path)
    @path = path
    @ip_addresses = []
  end

  def add_ip(ip)
    @ip_addresses << ip
  end
end



describe LogLine do
  let(:logline) { LogLine.new("/about") }
  describe "#new" do
    it "initializes with a path name and empty ip address array" do
      expect(logline.path).to eq("/about")
      expect(logline.ip_addresses).to eq([])
    end
  end
  describe "#add_ip" do
    it "adds an ip address to the internal array" do
    logline.add_ip("555.555.555.555")
    expect(logline.ip_addresses).to eq(["555.555.555.555"])
    end
    it "can add multiple ip addresses" do
      5.times do
        logline.add_ip("555.555.555.555")
      end
      expect(logline.ip_addresses.length).to eq(5)
    end
  end
end