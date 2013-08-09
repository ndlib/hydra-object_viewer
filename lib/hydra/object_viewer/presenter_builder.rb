module Hydra::ObjectViewer
  module PresenterBuilder
    module_function
    def call(object, context)
      presenter_name = "#{object.class.name}Presenter"
      presenter_class = find_presenter_class(presenter_name)
      presenter_class.new(object, context)
    end
    def find_presenter_class(presenter_name)
      presenter_class = Presenters.const_get(presenter_name)
    rescue NameError
      presenter_class = Hydra::ObjectViewer::Presenter
    end
  end
end
