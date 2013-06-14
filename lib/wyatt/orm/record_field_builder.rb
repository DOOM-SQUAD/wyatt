module Wyatt

  module Core
    
    module ORM

      class RecordFieldBuilder

        attr_reader :record_class, :name, :data

        def self.define_field(record_class, name, data)
          new(record_class, name, data).eval_prototypes
        end

        def initialize(record_class, name, data)
          @record_class = record_class
          @name         = name
          @data         = data
        end

        def eval_prototypes
          prototypes.each do |prototype|
            define_method(prototype)
          end
        end

        def prototypes
          method_list.select do |method|
            prototype_method?(method)
          end
        end

        def define_method(prototype)
          record_class.class_eval send(prototype)
        end

        def accessor_prototype
          <<-RUBY
            def #{name}
              @#{name}
            end
          RUBY
        end

        def mutator_prototype
          <<-RUBY
            def #{name}=(value)
              @#{name} = value
            end
          RUBY
        end

        def label_prototype
          <<-RUBY
            def #{name}_label
              "#{label}"
            end
          RUBY
        end

        def allowed_types_prototype
          <<-RUBY
            def #{name}_allowed_types
              #{allowed_types}
            end
          RUBY
        end

        def remote_type_prototype
          <<-RUBY
            def #{name}_remote_type
              "#{remote_type}"
            end
          RUBY
        end

        def label
          data['label']
        end

        def remote_type
          data['type']
        end

        def search_filter?
          data['search_filter']
        end

        def search_column?
          data['search_column']
        end

        private

        def method_list
          self.class.instance_methods(false)
        end

        def prototype_method?(method_symbol)
          method_symbol.to_s.split('_').last == 'prototype'
        end

      end

    end

  end

end
