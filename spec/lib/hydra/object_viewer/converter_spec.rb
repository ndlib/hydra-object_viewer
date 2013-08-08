require 'spec_helper'
require 'hydra/object_viewer/converter'

RSpec::Matchers.define :be_a_hydra_object_viewer_presenter do
  match do |actual_presenter|
    @actual_presenter = actual_presenter
  end
end

module Hydra::ObjectViewer
  describe Converter do
    let(:findable_object_id) { '1234' }

    subject { Hydra::ObjectViewer::Converter.new }
    let(:found_object) { double }
    let(:context) { double }
    before(:each) do
      subject.object_finder = lambda{|*| found_object }
    end
    specify {
      expect(subject.call(findable_object_id, context)).
      to be_a_hydra_object_viewer_presenter
    }
  end
end
