require './lib/parser'


describe Parser do
  describe "#options" do
    it "saves choice of total (t)" do
      opts = "t"
      parser = Parser.new(opts)
      expect(parser.choice).to eq(:total)
    end
    it "saves choice of total (T)" do
      opts = "T"
      parser = Parser.new(opts)
      expect(parser.choice).to eq(:total)
    end
    it "saves choice of unique (u)" do
      opts = "u"
      parser = Parser.new(opts)
      expect(parser.choice).to eq(:unique)
    end
    it "saves choice of unique (U)" do
      opts = "U"
      parser = Parser.new(opts)
      expect(parser.choice).to eq(:unique)
    end
    it "returns false if wrong selection" do
      ("a"..."s").each do |opts|
        parser = Parser.new(opts)
        expect(parser.choice).to eq(false)
      end
    end
  end
  let (:file)  { Tempfile.new }
  describe "#report -> total" do
    it "returns a sorted list of visited sites by total visits" do
      opts = "t"
      file << <<~LOG
      /about 555.555.555.555
      /about 666.666.666.666
      /home 111.111.111.111
      LOG
      file.flush
      log = Log.new(file)
      parser = Parser.new(opts)
      expected = "PATH       IP\n/about     2\n/home      1\n"
      expect(parser.report(log.generate)).to eq(expected)
    end
  end

  describe "#report -> unique" do
    it "returns a sorted list of visited sites by unique visits" do
      opts = "u"
      file << <<~LOG
      /about 555.555.555.555
      /about 666.666.666.666
      /about 111.111.111.111
      /home 111.111.111.111
      /home 111.111.111.111
      LOG
      file.flush
      log = Log.new(file)
      parser = Parser.new(opts)
      expected = "PATH       IP\n/about     3\n/home      1\n"
      expect(parser.report(log.generate)).to eq(expected)
    end
  end

end