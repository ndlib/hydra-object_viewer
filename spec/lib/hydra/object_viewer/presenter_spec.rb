require 'spec_helper'
require 'hydra/object_viewer/presenter'

module Hydra::ObjectViewer

  describe Presenter do
    let(:presented_object) { double }
    subject {Presenter.new(presented_object)}

    its(:object) { should == presented_object }

    it { should respond_to(:template_name) }
  end

end
