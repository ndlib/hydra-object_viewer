module Hydra::ObjectViewer
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)

      desc "Installs the Hydra::ObjectViewer::Engine."

      argument :mount_point, type: :string, default: '/object_viewer', banner: "/path/to/mount/engine"

      def copy_initializer
        template "hydra_object_viewer_config.rb", "config/initializers/hydra_object_viewer_config.rb"
      end

      def copy_routes
        route "mount Hydra::ObjectViewer::Engine, at: '#{File.join("/", mount_point)}'"
      end
    end
  end
end
