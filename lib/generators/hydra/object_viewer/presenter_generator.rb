module Hydra::ObjectViewer
  module Generators
    class PresenterGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("../templates", __FILE__)

      desc "Create a the Hydra::ObjectViewer Presenter."

      def create_presenter
        template "presenter.rb.erb", "app/presenters/hydra/object_viewer/presenters/#{file_name}_presenter.rb"
      end
    end
  end
end
