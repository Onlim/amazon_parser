require 'date'
require 'onlim/amazon_parser/configuration'
require 'onlim/amazon_parser/version'
require 'onlim/amazon_parser/date'

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
