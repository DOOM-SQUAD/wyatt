module Wyatt

  module Core

    class Record

      def self.add_field_to_class(field_name, allowed_types, remote_type)

        class_eval <<-RUBY

          def #{field_name}
            @#{field_name}
          end

          def #{field_name}=(value)
            unless #{field_name}_allowed_types.include?(value.class)            
              raise_#{field_name}_type_exception
            end

            @#{field_name} = value 
          end

          def #{field_name}_allowed_types
            #{allowed_types}
          end

          def #{field_name}_remote_type
            "#{remote_type}"
          end

          private

          def raise_#{field_name}_type_exception
            message = "#{field_name} only accepts instances from #{allowed_types}"
            raise Wyatt::Exceptions::InvalidType.new(message)
          end

        RUBY

      end

    end

  end

end

# support list of allowed types
