require 'spec_helper'

RSpec.describe Onlim::AmazonParser::Duration do
  subject { Onlim::AmazonParser::Duration }

  before do
    @periods = Onlim::AmazonParser::Duration::PERIODS
  end

  describe '#call' do
    context 'when ten minutes: PT10M' do
      it 'returns proper duration in seconds' do
        expect(subject.new('PT10M').call).to eq(10 * @periods[:minutes])
      end
    end

    context 'when five hours: PT5H' do
      it 'returns proper duration in seconds' do
        expect(subject.new('PT5H').call).to eq(5 * @periods[:hours])
      end
    end

    context 'when three days: P3D' do
      it 'returns proper duration in seconds' do
        expect(subject.new('P3D').call).to eq(3 * @periods[:days])
      end
    end

    context 'when forty five seconds: PT45S' do
      it 'returns proper duration in seconds' do
        expect(subject.new('PT45S').call).to eq(45)
      end
    end

    context 'when eight weeks: P8W' do
      it 'returns proper duration in seconds' do
        expect(subject.new('P8W').call).to eq(8 * @periods[:weeks])
      end
    end

    context 'when seven years: P7Y' do
      it 'returns proper duration in seconds' do
        expect(subject.new('P7Y').call).to eq(7 * @periods[:years])
      end
    end

    context 'when five hours ten minutes: PT5H10M' do
      it 'returns proper duration in seconds' do
        expect(subject.new('PT5H10M').call).to eq(5 * @periods[:hours] + 10 * @periods[:minutes])
      end
    end

    context 'when two years three hours ten minutes: P2YT3H10M' do
      it 'returns proper duration in seconds' do
        seconds = 2 * @periods[:years] + 3 * @periods[:hours] + 10 * @periods[:minutes]

        expect(subject.new('P2YT3H10M').call).to eq(seconds)
      end
    end

    context 'when period is in the past: -PT45S' do
      it 'returns proper duration is seconds' do
        expect(subject.new('-PT45S').call).to eq(-45)
      end
    end
  end
end
