require 'morphine'

module Hydra::ObjectViewer
  class ApplicationController < ActionController::Base
    include Morphine

    register :presenter_builder do
      Hydra::ObjectViewer.method(:presenter_for)
    end

    def show
      render presenter.template_name
    end

    def presenter
      @presenter ||= presenter_builder.call(params[:id])
    end
    helper_method :presenter
  end
end
