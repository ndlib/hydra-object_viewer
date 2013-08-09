require 'spec_helper'
require 'hydra/object_viewer/application_controller'

module Hydra::ObjectViewer

  describe ApplicationController do
    let(:object_id) { '1234' }
    let(:object) { double }
    let(:presenter) { double({template_name: template_name}) }

    before(:each) do
      subject.presenter_builder = lambda {|id, controller| presenter }
    end

    describe "presenting a valid template name" do
      before(:each) do
        get :show, id: object_id
      end
      its(:response) { should be_successful }
      it { should respond_to(:presenter) }
    end

  end

end
