require 'spec_helper'
require 'hydra/object_viewer/application_controller'

module Hydra::ObjectViewer

  describe ApplicationController do
    let(:object_id) { '1234' }
    let(:object) { double }
    let(:template_name) { 'show' }
    let(:presenter) { double({template_name: template_name}) }

    before(:each) do
      subject.object_builder = lambda{|id, *args| object}
      subject.presenter_builder = lambda{|object| presenter}
    end

    describe "presenting a valid template name" do
      it 'renders a persisted object' do
        get :show, id: object_id
        expect(response).to render_template(template_name)
      end
    end

    describe "presenting an invalid template name" do
      let(:template_name) {'this_view_does_not_exist'}
      it 'renders a persisted object' do
        expect {get :show, id: object_id}.to raise_error(ActionView::MissingTemplate)
      end
    end

  end

end
