module Wyatt

  module Core

    module ORM

      class RecordClassBuilder

        attr_reader :record_name, :schema_file_path,
                    :record_class_name, :raw_yaml_string,
                    :field_hash, :record_class

        def self.define_record(record_name, schema_file_path)
          new(record_name, schema_file_path).tap do |builder|
            builder.parse_yaml
            builder.define_class_constant
            builder.add_fields
          end
        end

        def initialize(record_name, schema_file_path)
          @record_name       = record_name
          @schema_file_path  = schema_file_path
          @record_class_name = classify_record_name
        end

        def classify_record_name
          record_name.split('_').map(&:capitalize).join
        end

        def parse_yaml
          @raw_yaml_string = File.read(@schema_file_path)
          @field_hash      = YAML.load(@raw_yaml_string)
        end

        def define_class_constant
          @record_class = record_namespace.const_set(
            record_class_name,
            Class.new(parent_record_class)
          )
        end
        
        
        def add_fields
          field_hash.each do |name, data|
            RecordFieldBuilder.define_field(record_class, name, data)
          end
        end

        private

        def record_namespace
          Wyatt::Core::ORM
        end

        def parent_record_class
          Wyatt::Core::ORM::Record
        end

      end

    end

  end

end
