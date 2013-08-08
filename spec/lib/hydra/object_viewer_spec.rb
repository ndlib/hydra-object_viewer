require 'spec_helper'
require 'hydra/object_viewer'

describe Hydra::ObjectViewer do
  its(:converter) { should be_an_instance_of Hydra::ObjectViewer::Converter }

  describe '.presenter_for' do
    let(:the_converter) { double }
    let(:findable_id) { 1234 }
    let(:the_presenter) { double }
    let(:context) { double}
    before(:each) do
      subject.stub(:converter).and_return(the_converter)
    end

    it 'should convert an ID and context to a presenter_for' do
      the_converter.should_receive(:call).with(findable_id, context).and_return(the_presenter)
      expect(subject.presenter_for(findable_id, context)).to eq(the_presenter)
    end
  end
end
