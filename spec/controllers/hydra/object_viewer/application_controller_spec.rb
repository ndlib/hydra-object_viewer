require 'spec_helper'

module Hydra::ObjectViewer

  class Presenter
    def initialize(object)
    end

    def template_name
      {text: 'Hello World'}
    end
  end

  require 'hydra/object_viewer/application_controller'

  describe ApplicationController do
    let(:object_id) { '1234' }
    it 'renders a persisted object' do
      subject.object_instantiator = lambda{|id, *args| Object.new}
      get :show, id: object_id
      expect(response.status).to eq(200)
    end

  end

end
