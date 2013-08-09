module Hydra::ObjectViewer
  module PresenterBuilder
    module_function
    def call(object, context)
      Hydra::ObjectViewer::Presenter.new(object, context)
    end
  end
end
