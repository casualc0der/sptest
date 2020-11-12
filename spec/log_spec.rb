require "tempfile"
require "./lib/log"
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
  describe "#options" do
    let(:log) {Log.new(file)}
    it "saves choice of total (t)" do
      log.option('t')

      expect(log.choice).to eq(:total)
    end
    it "saves choice of total (T)" do
      log.option('T')

      expect(log.choice).to eq(:total)
    end
    it "saves choice of unique (u)" do
      log.option('u')

      expect(log.choice).to eq(:unique)
    end
    it "saves choice of unique (U)" do
      log.option('U')

      expect(log.choice).to eq(:unique)
    end
    it "returns false if wrong selection" do
      ("a"..."s").each do |opts|
        log.option(opts)
        expect(log.choice).to eq(false)
      end
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
      log.option('t')
      log.generate
      expect(log.data.first).to respond_to(:report)
      expect(log.data.first.path).to eq("/about")
      expect(log.data.first.ip_addresses).to eq (["555.555.555.555"])
    end
  end
  end