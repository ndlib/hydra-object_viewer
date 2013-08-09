require 'morphine'

module Hydra::ObjectViewer
  class ApplicationController < ActionController::Base
    include Morphine

    register :presenter_builder do
      lambda {|id, controller|
        Hydra::ObjectViewer.presenter_for(id, controller)
      }
    end

    def show
      render 'show'
    end

    def presenter
      @presenter ||= presenter_builder.call(params[:id], self)
    end
    helper_method :presenter
  end
end
