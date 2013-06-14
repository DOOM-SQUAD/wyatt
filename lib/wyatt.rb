require 'yaml'
require 'faraday'
require 'faraday_middleware'

require_relative 'wyatt/exceptions'

require_relative 'wyatt/configuration'

require_relative 'wyatt/request'
require_relative 'wyatt/response'

require_relative 'wyatt/orm/record'
require_relative 'wyatt/orm/record_class_builder'
require_relative 'wyatt/orm/record_field_builder'

require_relative 'wyatt/railtie' if defined? Rails::Railtie

module Wyatt
  extend self

  def configured?
    !!Wyatt::Core::Configuration.raw_settings
  end

  def load_plugins
    registered_plugins.each { |plugin| plugin.load! }
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
