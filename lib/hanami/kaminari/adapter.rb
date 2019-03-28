require "hanami/kaminari/adapter/version"
require 'kaminari'

require 'hanami/kaminari/adapter/rom_relation_extension'
require 'hanami/kaminari/adapter/rom_relation_loaded_extension'
::ROM::Relation.send :include, Kaminari::Adapter::RomRelationExtension
::ROM::Relation::Loaded.send :include, Kaminari::Adapter::RomRelationLoadedExtension
::Hanami::Repository.send :include, Kaminari::ConfigurationMethods
