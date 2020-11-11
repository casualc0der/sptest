# frozen_string_literal: true

class Parser

  def report(log)
    report = ''.dup
    report << top_line
    log.sort! { |a, b| b.report <=> a.report }
    log.each do |logline|
      report << line(logline) << "\n"
    end
    report
  end

  private
  def top_line
    "PATH#{' ' * 25}VISITS\n"
  end

  def line(logline)
    "#{logline.path}#{' ' * (30-logline.path.length) } #{logline.report}"
  end

end
