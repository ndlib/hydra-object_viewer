require 'spec_helper'
require 'hydra/object_viewer/presenter_builder'

module Hydra::ObjectViewer

  describe PresenterBuilder do
    let(:presented_object) { double }
    subject {PresenterBuilder.new(presented_object)}

    its(:object) { should == presented_object }

    it { should respond_to(:template_name) }
  end

end
