module Hydra::ObjectViewer
  class Presenter
    attr_reader :object

    def initialize(object)
      @object = object
    end

    def template_name
      {text: 'Hello World'}
    end
  end
end
