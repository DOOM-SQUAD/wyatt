require 'yaml'
require 'faraday'
require 'faraday_middleware'

require_relative 'wyatt/configuration'

require_relative 'wyatt/request'
require_relative 'wyatt/response'

require_relative 'wyatt/railtie' if defined? Rails::Railtie

module Wyatt
  extend self

  def configured?
    !!Wyatt::Core::Configuration.raw_settings
  end

  def configured_plugins
    # call registered_plugins
    # query each constant for .configured?
  end

  def registered_plugins
    Wyatt.constants - [:Core]
  end

end
