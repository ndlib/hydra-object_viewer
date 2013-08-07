require 'spec_helper'
require 'hydra/object_viewer/presenter_conversion'

RSpec::Matchers.define :be_a_hydra_object_viewer_presenter do
  match do |actual_presenter|
    @actual_presenter = actual_presenter
  end
end

module Hydra::ObjectViewer
  describe PresenterConversion do
    let(:findable_object_id) { '1234' }

    describe 'object' do
      subject { Hydra::ObjectViewer::PresenterConversion.new(findable_object_id) }
      let(:found_object) { double }
      before(:each) do
        subject.object_finder = lambda{|id, *args| found_object }
      end
      its(:call) { should be_a_hydra_object_viewer_presenter }
    end

    describe 'conversion' do
      subject { Hydra::ObjectViewer::PresenterConversion(findable_object_id) }
      let(:conversion_instance) { double }
      let(:converted_return_value) { "RETURNED VALUE" }
      before(:each) do
        PresenterConversion.stub(:new).with(findable_object_id).and_return(conversion_instance)
        conversion_instance.should_receive(:call).and_return(converted_return_value)
      end
      it { should == converted_return_value }

    end
  end
end
