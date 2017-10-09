module Onlim
  module AmazonParser
    # AMAZON.DURATION
    class Duration
      PERIODS = {
        years: 31_557_600,
        months: 2_592_000,
        weeks: 604_800,
        days: 86_400,
        hours: 3_600,
        minutes: 60,
        seconds: 1
      }.freeze

      def initialize(input)
        @input      = input
        @components = parse(@input)
      end
      attr_reader :components

      def call
        raise 'Not an amazon duration input' if @components.nil?

        to_seconds
      end

      private

      def to_seconds
        seconds = 0

        PERIODS.keys.each do |period|
          seconds += components[period].to_i * PERIODS[period]
        end

        return -seconds if components[:sign]
        seconds
      end

      def parse(input)
        input.match(/^
          (?<sign>\+|-)?
          P(?:
            (?:
              (?:(?<years>\d+(?:[,.]\d+)?)Y)?
              (?:(?<months>\d+(?:[.,]\d+)?)M)?
              (?:(?<days>\d+(?:[.,]\d+)?)D)?
              (?<time>T
                (?:(?<hours>\d+(?:[.,]\d+)?)H)?
                (?:(?<minutes>\d+(?:[.,]\d+)?)M)?
                (?:(?<seconds>\d+(?:[.,]\d+)?)S)?
              )?
            ) |
            (?<weeks>\d+(?:[.,]\d+)?W)
          ) # Duration
        $/x)
      end
    end
  end
end
