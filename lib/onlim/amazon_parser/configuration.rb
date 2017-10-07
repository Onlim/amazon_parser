module Onlim
  module AmazonParser
    # config
    class Configuration
      def initialize
        @date_range_key  = 'date-period'
        @date_key        = 'date'
        @time_range_key  = 'time-period'
        @time_key        = 'time'
      end

      attr_accessor :date_range_key,
                    :date_key,
                    :time_range_key,
                    :time_key
    end
  end
end
