require 'yaml'

module Wyatt

  module Configuration

    CORE_SETTINGS = 'core'

    def self.load!(file_path)
      @file_path     = file_path
      @core_settings = Configuration.raw_settings[CORE_SETTINGS]
    end

    def self.raw_settings
      YAML::load(IO.read(Configuration.file_path))
    end

    def self.file_path
      @file_path
    end

    def self.core_settings
      @core_settings
    end

  end

end
