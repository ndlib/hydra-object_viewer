require 'morphine'
module Hydra::ObjectViewer
  # Responsible for taking a findable key and converting that key
  # to a presenter
  class Converter
    include Morphine

    register :object_finder do
      lambda {|pid, context|
        ActiveFedora::Base.find(pid, cast: true)
      }
    end

    register :presenter_builder do
      require 'hydra/object_viewer/presenter_builder'
      lambda {|object, context|
        Hydra::ObjectViewer::PresenterBuilder.new(object, context)
      }
    end

    def call(findable_id, context)
      object = object_finder.call(findable_id, context)
      presenter_builder.call(object, context)
    end
  end
end
