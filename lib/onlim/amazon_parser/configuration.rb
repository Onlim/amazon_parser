module Onlim
  module AmazonParser
    class Configuration
      def initialize
        @hash_response   ||= true
        @date_range_key  ||= 'date-period'
        @date_key        ||= 'date'
        @time_range_key  ||= 'time-period'
        @time_key        ||= 'time'
      end

      attr_accessor :hash_response,
                    :date_range_key,
                    :date_key,
                    :time_range_key,
                    :time_key
    end
  end
end
