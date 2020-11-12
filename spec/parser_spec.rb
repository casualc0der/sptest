require './lib/parser'


describe Parser do

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
      expected = "PATH                         VISITS\n/about                         2\n/home                          1\n"
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
      expected =  "PATH                       UNIQUE VISITS\n/about                         3\n/home                          0\n"
      expect(parser.report(log.generate)).to eq(expected)
    end
  end

end