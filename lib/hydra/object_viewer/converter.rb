require 'morphine'
module Hydra::ObjectViewer
  # Responsible for taking a findable key and converting that key
  # to a presenter
  class Converter
    include Morphine

    register :object_finder do |pid|
      ActiveFedora::Base.find(pid, cast: true)
    end

    register :presenter_builder do
      require 'hydra/object_viewer/presenter'
      Hydra::ObjectViewer::Presenter.method(:new)
    end

    def call(findable_id)
      object = object_finder(findable_id)
      presenter_builder.call(object)
    end
  end
end
