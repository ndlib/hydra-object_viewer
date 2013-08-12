module Hydra::ObjectViewer
  module PresenterBuilder
    module_function
    def call(object, context)
      presenter_name = get_presenter_name(object)
      presenter_class = find_presenter_class(presenter_name)
      presenter_class.new(object, context)
    end

    def get_presenter_name(object)
      if object.respond_to?(:presenter_name)
        object.presenter_name
      else
        "#{object.class.name}Presenter"
      end
    end

    def find_presenter_class(presenter_name)
      presenter_class = Presenters.const_get(presenter_name)
    rescue NameError
      presenter_class = Hydra::ObjectViewer::Presenter
    end
  end
end
