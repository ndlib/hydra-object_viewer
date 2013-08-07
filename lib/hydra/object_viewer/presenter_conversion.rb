module Hydra::ObjectViewer
  class PresenterConversion
    include Morphine

    register :object_finder do
      ActiveFedora::Base.method(:find)
    end

    register :presenter_builder do
      require 'hydra/object_viewer/presenter'
      Hydra::ObjectViewer::Presenter.method(:new)
    end

    attr_reader :findable_id, :finder_options
    def initialize(findable_id, finder_options = {})
      @findable_id, @finder_options = findable_id, finder_options
    end

    def call
      object = object_finder.call(findable_id, finder_options)
      presenter_builder.call(object)
    end
  end
end
