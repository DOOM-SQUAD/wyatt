module Wyatt

  module Core

    class Record

      def self.add_field_to_class(field_name, type)
        class_eval <<-RUBY
          def #{field_name}
            @#{field_name}
          end

          def #{field_name}=(value)
            raise_#{field_name}_type_exception if value.class != #{type}
            @#{field_name} = value 
          end

          private

          def raise_#{field_name}_type_exception
            message = "#{field_name} only accepts an instance of #{type}"
            raise Wyatt::Exceptions::InvalidType.new(message)
          end
        RUBY
      end

    end

  end

end
