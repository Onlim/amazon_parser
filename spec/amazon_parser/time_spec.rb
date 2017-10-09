require 'spec_helper'

RSpec.describe Onlim::AmazonParser::Time do
  subject { Onlim::AmazonParser::Time }

  describe '#call' do
    context 'when a time range' do
      it 'returns proper value' do
        expect(subject.new('AF').call).to eq('time-period' => '12:00:00/17:00:00')
      end
    end

    context 'when not a time range' do
      it 'returns proper value' do
        expect(subject.new('12:00').call).to eq('time' => '12:00:00')
      end
    end

    context 'when not a valid input' do
      it 'raise exception' do
        expect { subject.new('test').call }.to raise_error
      end
    end
  end
end
