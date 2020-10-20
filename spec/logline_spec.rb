# frozen_string_literal: true

class LogLine
  attr_reader :path, :ip_addresses
  def initialize(path)
    @path = path
    @ip_addresses = []
  end

  def add_ip(ip)
    @ip_addresses << ip
  end

  def report_total_visits
    @ip_addresses.length
  end

  def report_unique_visits
    @ip_addresses.uniq.length
  end

end

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
  describe '#report_unique_visits' do
    it 'tallies unique visits' do
      5.times do
        logline.add_ip('333.333.333.333')
      end
      2.times do
        logline.add_ip('123.456.123.123')
      end
      expect(logline.report_unique_visits).to eq(2)
    end
  end

end
