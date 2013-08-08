require 'morphine'
module Hydra::ObjectViewer
  # Responsible for taking a findable key and converting that key
  # to a presenter
  class Converter
    include Morphine

    register :object_finder do
      lambda {|pid, controller|
        ActiveFedora::Base.find(pid, cast: true)
      }
    end

    register :presenter_builder do
      require 'hydra/object_viewer/presenter_builder'
      lambda {|object, controller|
        Hydra::ObjectViewer::PresenterBuilder.new(object, controller)
      }
    end

    def call(findable_id, controller)
      object = object_finder.call(findable_id, controller)
      presenter_builder.call(object, controller)
    end
  end
end
