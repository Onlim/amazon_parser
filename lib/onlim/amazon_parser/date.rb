module Onlim
  module AmazonParser
    class Date
      SEASONS = {
        'SP' => [3, 5],
        'SU' => [6, 8],
        'FA' => [9, 11],
        'WI' => [12, 2]
      }.freeze

      def initialize(input)
        @input              = input
        @year, @month, @day = @input.split('-')
        @config             = AmazonParser.config
      end

      def call
        @response = resolve

        if @config.hash_response
          { key => value }
        else
          value
        end
      end

      private

      def resolve
        return ::Date.today   if @year == 'PRESENT_REF'
        return year_or_decade if @month.nil? && @day.nil?
        return season_period  if SEASONS.keys.include?(@month)

        parse_date
      end

      def key
        range? ? @config.date_range_key : @config.date_key
      end

      def value
        @response.to_s.gsub('..', '/')
      end

      def range?
        @response.is_a?(Range)
      end

      def year_or_decade
        start_year = decade? ? @year.tr('X', '0').to_i : @year.to_i
        end_year   = decade? ? @year.tr('X', '9').to_i : @year.to_i

        (::Date.new(start_year, 1, 1)..::Date.new(end_year, -1, -1))
      end

      def decade?
        !@year.index('X').nil?
      end

      def season_period
        start_month, end_month = SEASONS[@month]
        year = start_month < end_month ? @year.to_i : @year.to_i + 1

        (::Date.new(@year.to_i, start_month, 1)..::Date.new(year, end_month, -1))
      end

      def parse_date
        return week if @month[0] == 'W'

        ::Date.parse(@input)
      end

      def week
        start_week = ::Date.parse(@input)

        end_week   = start_week + 6
        start_week += 5 if @day == 'WE'

        (start_week..end_week)
      end
    end
  end
end
