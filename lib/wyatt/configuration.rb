module Wyatt

  module Core

    module Configuration
      extend self

      CORE_SETTINGS = :core

      def load!(file_path)
        @file_path     = file_path
        @raw_settings  = read_yaml
        @core_settings = @raw_settings[CORE_SETTINGS]
      end

      def read_yaml
        YAML::load(IO.read(Wyatt::Core::Configuration.file_path))
      end

      def raw_settings
        @raw_settings
      end

      def file_path
        @file_path
      end

      def core_settings
        @core_settings
      end

    end

  end

end
