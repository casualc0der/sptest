# frozen_string_literal: true

class Parser

  def output(log)
    report = ''.dup
    report << top_line
    log.sort! { |a, b| b.report <=> a.report }
    log.each do |logline|
      report << extract_logline_data(logline) << "\n"
    end
    report
  end

  private
  def top_line
    "PATH#{' ' * 25}TOTAL\n"
  end

  def extract_logline_data(logline)
    "#{logline.path}#{' ' * (30-logline.path.length) } #{logline.report}"
  end

end
