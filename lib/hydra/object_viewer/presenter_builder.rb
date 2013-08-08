module Hydra::ObjectViewer
  class PresenterBuilder
    attr_reader :object, :context

    def initialize(object, context)
      @object = object
      @context = context
    end

    def template_name
      {text: 'Hello World'}
    end
  end
end
