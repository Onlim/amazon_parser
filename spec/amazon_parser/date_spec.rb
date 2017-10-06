require 'spec_helper'

RSpec.describe Onlim::AmazonParser::Date do
  subject { Onlim::AmazonParser::Date }
  describe '#call' do
    context 'when input is PRESENT_REF' do
      it 'returns today date' do
        expect(subject.new('PRESENT_REF').call).to eq(Date.today.to_s)
      end
    end

    context 'when input is a year' do
      it 'returns proper period' do
        expect(subject.new('2016').call).to eq('2016-01-01/2016-12-31')
      end
    end

    context 'when input is a decade' do
      it 'returns proper period' do
        expect(subject.new('201X').call).to eq('2011-01-01/2019-12-31')
      end
    end

    context 'when input refers to a season' do
      it 'calls proper method' do
        expect_any_instance_of(subject).to receive(:season_period).once

        subject.new('2017-WI').call
      end

      it 'returns proper period'
    end

    context 'when input refers to a week' do
      it 'returns proper period' do
        expect(subject.new('2017-W52').call).to eq('2017-12-25/2017-12-31')
      end
    end

    context 'when input refers to a week weekend' do
      it 'returns proper period' do
        expect(subject.new('2017-W52-WE').call).to eq('2017-12-30/2017-12-31')
      end
    end

    context 'when input is specifi date' do
      it 'returns proper date' do
        expect(subject.new('2017-10-06').call).to eq('2017-10-06')
      end
    end
  end
end
