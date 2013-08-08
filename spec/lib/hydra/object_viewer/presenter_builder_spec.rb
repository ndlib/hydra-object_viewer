require 'spec_helper'
require 'hydra/object_viewer/presenter_builder'

module Hydra::ObjectViewer

  describe PresenterBuilder do
    let(:presented_object) { double }
    let(:the_controller) { double }
    subject {PresenterBuilder.new(presented_object, the_controller)}

    its(:object) { should == presented_object }
    its(:controller) { should == the_controller }

    it { should respond_to(:template_name) }
  end

end
