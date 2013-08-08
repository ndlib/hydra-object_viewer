require 'spec_helper'
require 'hydra/object_viewer/application_controller'

module Hydra::ObjectViewer

  describe ApplicationController do
    let(:object_id) { '1234' }
    let(:object) { double }
    let(:template_name) { 'show' }
    let(:presenter) { double({template_name: template_name}) }

    before(:each) do
      subject.presenter_builder = lambda {|id, controller| presenter }
    end

    describe "presenting a valid template name" do
      before(:each) do
        get :show, id: object_id
      end

      its(:response) { should render_template(template_name) }

      it { should respond_to(:presenter) }
    end

    describe "presenting an invalid template name" do
      let(:template_name) {'this_view_does_not_exist'}
      it 'renders a persisted object' do
        expect {get :show, id: object_id}.to raise_error(ActionView::MissingTemplate)
      end
    end

  end

end
