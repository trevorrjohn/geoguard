require 'spec_helper'

RSpec.describe GeoGuard::Configuration do
  describe '#format=' do
    it 'is valid when :CSV' do
      subject = GeoGuard::Configuration.new
      subject.format = :CSV
      expect(subject.format).to eq :CSV
    end

    it 'is valid when :ZIP' do
      subject = GeoGuard::Configuration.new
      subject.format = :ZIP
      expect(subject.format).to eq :ZIP
    end

    it 'is valid when :MMDB' do
      subject = GeoGuard::Configuration.new
      subject.format = :MMDB
      expect(subject.format).to eq :MMDB
    end

    it 'raises an error when invalid format' do
      subject = GeoGuard::Configuration.new
      expect do
        subject.format = :SQL
      end.to raise_error(GeoGuard::Configuration::InvalidFormat, "SQL is not a valid format. Only [:CSV, :MMDB, :ZIP] are allowed.")
    end
  end
end
