require 'morphine'

module Hydra::ObjectViewer
  class ApplicationController < ActionController::Base
    include Morphine

    register :object_builder do
      ActiveFedora::Base.method(:find)
    end

    register :presenter_builder do
      Hydra::ObjectViewer::Presenter.method(:new)
    end

    def show
      object = instantiate_object(params[:id])
      presenter = present_object(object)
      render presenter.template_name
    end

    private

    def instantiate_object(id)
      object_builder.call(id, cast: true) # The object casting is ActiveFedora specific :(
    end

    def present_object(object)
      presenter_builder.call(object)
    end
  end
end
