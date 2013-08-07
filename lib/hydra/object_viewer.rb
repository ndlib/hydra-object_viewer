require "hydra/object_viewer/engine"
require 'hydra/object_viewer/converter'
module Hydra
  module ObjectViewer
    module_function
    def presenter_for(findable_object_id, context)
      converter.call(findable_object_id, context)
    end

    def converter
      @converter ||= Converter.new
    end
  end
end
