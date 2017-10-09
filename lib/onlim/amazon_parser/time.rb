module Onlim
  module AmazonParser
    class Time
      TIME_PERIODS = {
        'MO' => '06:00:00/12:00:00',
        'AF' => '12:00:00/17:00:00',
        'EV' => '17:00:00/20:00:00',
        'NI' => '20:00:00/23:59:00'
      }.freeze

      def initialize(input)
        @input  = input
        @config = AmazonParser.config
      end

      def call
        { key => value }
      end

      def key
        range? ? @config.time_range_key : @config.time_key
      end

      def value
        return TIME_PERIODS[@input] if range?

        DateTime.parse(@input).strftime('%H:%M:%S')
      rescue ArgumentError
        raise 'Ivalid input'
      end

      def range?
        TIME_PERIODS.keys.include?(@input)
      end
    end
  end
end
