require 'spec_helper'
require 'hydra/object_viewer/presenter_builder'

module Hydra::ObjectViewer

  describe PresenterBuilder do
    let(:presented_object) { double }
    let(:the_context) { double }
    subject {PresenterBuilder.call(presented_object, the_context)}

    it { should be_a_kind_of Presenter }
  end

end
