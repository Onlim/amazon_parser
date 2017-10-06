module Onlim
  module AmazonParser
    class Date
      SEASONS = %w[
        SP
        SU
        FA
        WI
      ].freeze

      def initialize(input)
        @input              = input
        @year, @month, @day = @input.split('-')
      end

      def call
        resolve.to_s.gsub('..', '/')
      end

      private

      def resolve
        return ::Date.today   if @year == 'PRESENT_REF'
        return year_or_decade if @month.nil? && @day.nil?
        return season_period  if SEASONS.include?(@month)

        parse_date
      end

      def year_or_decade
        start_year = decade? ? @year.tr('X', '1').to_i : @year.to_i
        end_year   = decade? ? @year.tr('X', '9').to_i : @year.to_i

        (::Date.new(start_year, 1, 1)..::Date.new(end_year, -1, -1))
      end

      def decade?
        !@year.index('X').nil?
      end

      def season_period; end

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
