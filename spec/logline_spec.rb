require './lib/logline'

describe LogLine do
  let(:logline) { LogLine.new('/about') }
  let(:logline2)  { LogLine.new('/home/1') }
  let(:logline3)  { LogLine.new('/contact') }
  describe '#new' do
    it 'initializes with a path name and empty ip address array' do
      expect(logline.path).to eq('/about')
      expect(logline.ip_addresses).to eq([])
    end
  end
  describe '#add_ip' do
    it 'adds an ip address to the internal array' do
      logline.add_ip('555.555.555.555')
      expect(logline.ip_addresses).to eq(['555.555.555.555'])
    end
    it 'can add multiple ip addresses' do
      5.times do
        logline.add_ip('555.555.555.555')
      end
      expect(logline.ip_addresses.length).to eq(5)
    end
  end
  describe '#report_total_visits' do
    it 'tallies amount of visits' do
      5.times do
        logline.add_ip('123.123.123.123')
      end
      expect(logline.report_total_visits).to eq(5)
    end
  end

  # Not sure this was the correct implementation -> this counts unique ip addresses per path
  # I guess we should report unique visits i.e where a path has been visited by a specific
  # ip only once...
  # describe '#report_unique_visits' do
  #   it 'tallies unique visits' do
  #     5.times do
  #       logline.add_ip('333.333.333.333')
  #     end
  #     2.times do
  #       logline.add_ip('123.456.123.123')
  #     end
  #     expect(logline.report_unique_visits).to eq(2)
  #   end
  # end

  # updated implementation
  describe '#report_unique_visits' do
    it 'tallies unique visits' do
      5.times do
        logline.add_ip('333.333.333.333')
      end
      2.times do
        logline.add_ip('123.456.123.123')
      end
      logline.add_ip("111.111.111.111")
      expect(logline.report_unique_visits).to eq(1)
    end
  end
  end
