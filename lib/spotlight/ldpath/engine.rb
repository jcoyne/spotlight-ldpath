module Spotlight::Ldpath
  class Engine < ::Rails::Engine
    initializer "spotlight.dor.initialize" do
      Spotlight::Engine.config.resource_providers << Spotlight::Resources::LdpathHarvester
      Spotlight::Engine.config.new_resource_partials ||= []
      Spotlight::Engine.config.new_resource_partials << 'spotlight/resources/ldpath/ldpath'
    end
  end
end