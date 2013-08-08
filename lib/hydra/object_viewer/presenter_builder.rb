module Hydra::ObjectViewer
  class PresenterBuilder
    attr_reader :object, :controller

    def initialize(object, controller)
      @object = object
      @controller = controller
    end

    def template_name
      {text: 'Hello World'}
    end
  end
end
