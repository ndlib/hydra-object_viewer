require 'morphine'

module Hydra::ObjectViewer
  class ApplicationController < ActionController::Base
    include Morphine

    register :object_instantiator do
      ActiveFedora::Base.method(:find)
    end

    register :presenter_instantiator do
      Hydra::ObjectViewer::Presenter.method(:new)
    end

    def show
      object = instantiate_object(params[:id])
      presenter = present_object(object)
      render presenter.template_name
    end

    private

    def instantiate_object(id)
      object_instantiator.call(id, cast: true) # The object casting is ActiveFedora specific :(
    end

    def present_object(object)
      presenter_instantiator.call(object)
    end
  end
end
