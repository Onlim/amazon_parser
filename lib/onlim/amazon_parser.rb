require 'date'
require 'onlim/amazon_parser/configuration'
require 'onlim/amazon_parser/version'
require 'onlim/amazon_parser/date'
require 'onlim/amazon_parser/duration'
require 'onlim/amazon_parser/time'

module Onlim
  # :nodoc
  module AmazonParser
    @config = Configuration.new

    class << self
      attr_accessor :config
    end

    def self.configure
      yield config
    end
  end
end
