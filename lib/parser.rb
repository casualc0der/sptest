# frozen_string_literal: true

class Parser

  def report(log)
    report = ''.dup
    report << top_line
    log.sort! { |a, b| b.report <=> a.report }
    log.each do |line|
      report << line(line) << "\n"
    end
    report
  end

  private
  def top_line
    "PATH#{' ' * 25}VISITS\n"
  end

  def line(line)
    "#{line.path}#{' ' * (30-line.path.length) } #{line.report}"
  end

end
