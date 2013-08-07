require 'spec_helper'
require 'hydra/object_viewer/application_controller'

module Hydra::ObjectViewer

  describe ApplicationController do
    let(:object_id) { '1234' }
    let(:object) { double }
    let(:presenter) { double({template_name: {text: 'Hello World'}}) }

    it 'renders a persisted object' do
      subject.object_builder = lambda{|id, *args| object}
      subject.presenter_builder = lambda{|object| presenter}
      get :show, id: object_id
      expect(response.status).to eq(200)
    end
  end

end
