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
