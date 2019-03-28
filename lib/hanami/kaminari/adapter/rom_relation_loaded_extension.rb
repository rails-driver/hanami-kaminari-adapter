module Kaminari
  module Adapter
    module RomRelationLoadedExtension
      include Kaminari::PageScopeMethods

      delegate :total_count, :limit_value, :offset_value, to: :source

      def method_missing(name, *args, &block)
        return super unless name.in? %i[default_per_page max_per_page max_pages]
        repo_name = (Hanami::Model.container.mappers[self.source.name.relation].elements[:entity].model.to_s + 'Repository').constantize
        repo_name.send(name, *args, &block)
      end
    end
  end
end