require "tempfile"
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
describe Log do
  let(:file) { Tempfile.new("weblog.log") }
  describe "#open" do
  it "opens the supplied file and returns raw data" do
    file << "hello"
    file.flush
    log = Log.new(file)
    expect(log.open).to eq("hello")
  end
  it "raises exception if file is empty" do
    log = Log.new(file)
    expect { log.open }.to raise_exception(RuntimeError, "Please supply valid file")
  end
  end
  describe "#format" do
    it "returns data split by newline and space" do
      file << <<~LOG
        /about 123.456.789.123
        /home 555.555.555.555
      LOG
      file.flush
      log = Log.new(file)
      expected = [["/about", "123.456.789.123"], ["/home", "555.555.555.555"]]
      expect(log.format).to eq(expected)
    end
    it "raises exception if malformed data" do
      file << "/about 123.456.789\t/home 555.555.555"
      file.flush
      log = Log.new(file)
      expect {log.format }.to raise_exception(RuntimeError, "Please supply file in correct format")
    end
  end
  describe "#generate" do
    let(:file) { Tempfile.new }

    it "creates loglines from the supplied log" do
      file << <<~LOG
        /about 555.555.555.555
        /home/1 123.456.789.123
      LOG
      file.flush
      log = Log.new(file)
      log.generate
      expect(log.data.first).to be_instance_of(LogLine)
      expect(log.data.first.path).to eq("/about")
      expect(log.data.first.ip_addresses).to eq (["555.555.555.555"])
    end
  end
  end