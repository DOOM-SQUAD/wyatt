require 'yaml'

module Wyatt

  module Configuration
    extend self

    CORE_SETTINGS = :core

    def load!(file_path)
      @file_path     = file_path
      @raw_settings  = Configuration.parse_settings
      @core_settings = @raw_settings[CORE_SETTINGS]
    end

    def raw_settings
      @raw_settings
    end

    def parse_settings
      YAML::load(IO.read(Configuration.file_path))
    end

    def file_path
      @file_path
    end

    def core_settings
      @core_settings
    end

  end

end
