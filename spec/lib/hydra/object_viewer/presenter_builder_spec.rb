require 'spec_helper'
require 'hydra/object_viewer/presenter_builder'

module Hydra::ObjectViewer

  describe PresenterBuilder do
    let(:presented_object) { double }
    let(:the_context) { double }
    subject {PresenterBuilder.new(presented_object, the_context)}

    it { should respond_to :object }
    it { should respond_to :context }
    it { should respond_to(:template_name) }
  end

end
