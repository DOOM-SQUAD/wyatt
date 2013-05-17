require 'yaml'
require 'faraday'
require 'faraday_middleware'

require_relative 'wyatt/configuration'
require_relative 'wyatt/service'
require_relative 'wyatt/request'
require_relative 'wyatt/response'

module Wyatt

  def self.configured?
    !!Wyatt::Configuration.core_settings    
  end

end
