require "hydra/object_viewer/engine"
require 'hydra/object_viewer/converter'
require 'hydra/object_viewer/presenter'
require 'hydra/object_viewer/value_presenter'
module Hydra
  module ObjectViewer
    module_function
    def presenter_for(findable_object_id, context)
      converter.call(findable_object_id, context)
    end

    def object_finder(&finder_proc)
      converter.object_finder = finder_proc
    end

    def converter
      @converter ||= Converter.new
    end
  end
end
