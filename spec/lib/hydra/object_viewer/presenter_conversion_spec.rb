require 'spec_helper'
require 'hydra/object_viewer/presenter_conversion'

RSpec::Matchers.define :be_a_hydra_object_viewer_presenter do
  match do |actual_presenter|
    @actual_presenter = actual_presenter
  end
end

describe Hydra::ObjectViewer::PresenterConversion do
  subject { Hydra::ObjectViewer::PresenterConversion.new(findable_object_id) }
  let(:findable_object_id) { '1234' }
  let(:found_object) { double }
  before(:each) do
    subject.object_finder = lambda{|id, *args| found_object }
  end
  its(:call) { should be_a_hydra_object_viewer_presenter }
end
