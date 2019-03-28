module Kaminari
  module Adapter
    module RomRelationExtension
      def limit_value
        dataset.opts[:limit] || 0
      end

      def offset_value
        dataset.opts[:offset] || 0
      end

      def total_count
        dataset.unlimited.unordered.count
      end

      class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{Kaminari.config.page_method_name}(num = 1)
            num = [num.to_i, 1].max - 1
            limit(Kaminari.config.default_per_page).offset(Kaminari.config.default_per_page * num)
          end
      RUBY

      define_method(:per, Kaminari::PageScopeMethods.instance_method(:per))
      define_method(:padding, Kaminari::PageScopeMethods.instance_method(:padding))

      def method_missing(name, *args, &block)
        return super unless name.in? %i[max_per_page default_per_page]
        repo_name = (Hanami::Model.container.mappers[self.name.relation].elements[:entity].model.to_s + 'Repository').constantize
        repo_name.send(name, *args, &block)
      end
    end
  end
end