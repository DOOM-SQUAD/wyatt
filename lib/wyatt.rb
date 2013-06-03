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
    registered_plugins.map do |plugin|
      plugin.configured?
    end
  end

  def registered_plugins
    plugin_symbols = Wyatt.constants - [:Core]
    plugin_symbols.map do |symbol|
      Wyatt.const_get symbol
    end
  end

end
