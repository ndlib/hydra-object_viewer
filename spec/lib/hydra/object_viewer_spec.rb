require 'spec_helper'
require 'hydra/object_viewer'

describe Hydra::ObjectViewer do
  its(:converter) { should be_an_instance_of Hydra::ObjectViewer::Converter }

  describe '.presenter_for' do
    let(:the_converter) { double }
    let(:findable_id) { 1234 }
    let(:the_presenter) { double }
    before(:each) do
      subject.stub(:converter).and_return(the_converter)
    end

    specify {
      the_converter.should_receive(:call).with(findable_id).and_return(the_presenter)
      expect(subject.presenter_for(findable_id)).to eq(the_presenter)
    }
  end
end
