class Parser
  attr_reader :choice
  def initialize(opts)
    @choice = option(opts)
  end
  def option(opts)
    return :total if opts == "t" || opts == "T"
    return :unique  if opts == "u" || opts == "U"
    false
  end
  def report(log)
    return report_total(log) if @choice == :total
    return report_unique(log) if @choice == :unique

  end
  private
  def report_total(log)
    report = ""
    report << top_line_total
    log.sort! {|a, b| b.report_total_visits <=> a.report_total_visits}
    log.each do |line|
      report << line_total(line) << "\n"
    end
    report
  end

  def top_line_total
    "PATH#{' ' * 7}IP\n"
  end
  def line_total(line)
    "#{line.path}#{' ' * (10-line.path.length) } #{line.report_total_visits}"
  end
  def report_unique(log)
    report = ""
    report << top_line_unique
    log.sort! {|a, b| b.report_unique_visits <=> a.report_unique_visits}
    log.each do |line|
      report << line_unique(line) << "\n"
    end
    report
  end
  def top_line_unique
    "PATH#{' ' * 7}IP\n"
  end
  def line_unique(line)
    "#{line.path}#{' ' * (10-line.path.length) } #{line.report_unique_visits}"
  end
end





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