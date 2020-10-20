require "tempfile"
class Log
  def initialize(raw_data)
    @raw_data = raw_data
  end

  def open
    raise "Please supply valid file" if File.size(@raw_data).zero?
    File.read(@raw_data)
  end
  def format
    raise "Please supply file in correct format" unless validation?
    open.split("\n")
  end
  private
  def validation?
    open.split("\n").all? {|line| format_checker(line)}
  end
  def format_checker(line)
    /\/.+ (\d{3}\.){3}\d{3}/.match(line)
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
    it "returns data split by newline" do
      file << <<~LOG
        /about 123.456.789.123
        /home 555.555.555.555
      LOG
      file.flush
      log = Log.new(file)
      expected = ["/about 123.456.789.123", "/home 555.555.555.555"]
      expect(log.format).to eq(expected)
    end
    it "raises exception if malformed data" do
      file << "/about 123.456.789\t/home 555.555.555"
      file.flush
      log = Log.new(file)
      expect {log.format }.to raise_exception(RuntimeError, "Please supply file in correct format")
    end
  end
end