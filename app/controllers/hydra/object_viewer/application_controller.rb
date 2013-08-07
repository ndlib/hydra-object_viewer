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
      render presenter.template_name
    end

    def presenter
      @presenter ||= begin
                       object = instantiate_object(params[:id])
                       present_object(object)
                     end
    end
    helper_method :presenter

    private

    def instantiate_object(id)
      object_builder.call(id, cast: true) # The object casting is ActiveFedora specific :(
    end

    def present_object(object)
      presenter_builder.call(object)
    end
  end
end
