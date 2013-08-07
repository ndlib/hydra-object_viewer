module Hydra::ObjectViewer
  class ApplicationController < ActionController::Base
    def show
      render text: 'hello world'
    end
  end
end
