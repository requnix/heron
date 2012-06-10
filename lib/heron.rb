require 'heron/version'
require 'heron/explorer'
require 'heron/identifier'

module Heron
  def self.const_missing(c)
    Object.const_get(c)
  end
end
