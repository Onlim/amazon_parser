require 'date'
require 'onlim/amazon_parser/configuration'
require 'onlim/amazon_parser/version'
require 'onlim/amazon_parser/date'

module Onlim
 module AmazonParser
   @config = Configuration.new

   class << self
     attr_accessor :config
   end

   def self.configure
     yield self.config
   end
 end
end
