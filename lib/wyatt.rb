require 'yaml'
require 'faraday'
require 'faraday_middleware'

require_relative 'wyatt/configuration'
require_relative 'wyatt/request'
require_relative 'wyatt/response'

require_relative 'wyatt/railtie' if defined? Rails::Railtie

module Wyatt

  def self.configured?
    !!Wyatt::Configuration.raw_settings
  end

end
