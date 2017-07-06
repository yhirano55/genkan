require "genkan/config"
require "genkan/engine"

module Genkan
  def self.configure
    yield config
  end

  def self.config
    @_config ||= Config.new
  end
end
