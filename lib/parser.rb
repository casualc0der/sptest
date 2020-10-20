# frozen_string_literal: true

class Parser
  attr_reader :choice

  def initialize(opts)
    @choice = option(opts)
  end

  def option(opts)
    total = %w[t T]
    unique = %w[u U]
    return :total if total.include?(opts)
    return :unique if unique.include?(opts)

    false
  end

  def report(log)
    return report_total(log) if @choice == :total

    report_unique(log)

  end

  private

  def report_total(log)
    report = ''.dup
    report << top_line_total
    log.sort! { |a, b| b.report_total_visits <=> a.report_total_visits }
    log.each do |line|
      report << line_total(line) << "\n"
    end
    report
  end

  def top_line_total
    "PATH#{' ' * 25}VISITS\n"
  end

  def line_total(line)
    "#{line.path}#{' ' * (30-line.path.length) } #{line.report_total_visits}"
  end

  def report_unique(log)
    report = ''.dup
    report << top_line_unique
    log.sort! { |a, b| b.report_unique_visits <=> a.report_unique_visits }
    log.each do |line|
      report << line_unique(line) << "\n"
    end
    report
  end

  def top_line_unique
    "PATH#{' ' * 23}UNIQUE VISITS\n"
  end

  def line_unique(line)
    "#{line.path}#{' ' * (30 - line.path.length)} #{line.report_unique_visits}"
  end
end
