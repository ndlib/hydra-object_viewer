require 'spec_helper'

describe Hydra::ObjectViewer::Presenter do
  let(:the_model) {
    double(title: 'The Model Name', description: 'The Model Description')
  }
  let(:the_context) { double }
  subject { Hydra::ObjectViewer::Presenter.new(the_model, the_context) }

  it {should respond_to(:model) }
  it {should respond_to(:context) }
  its(:title) { should == the_model.title }
  its(:description) { should == the_model.description }

  its(:related_contents) {
    expect{ subject.related_contents }.to raise_error(NotImplementedError)
  }

  its(:metadata_attributes) {
    expect{ subject.metadata_attributes }.to raise_error(NotImplementedError)
  }

  describe 'classification' do
    it 'should delegate to model#classification' do
      the_model.stub(:classification).and_return("MY CLASSIFICATION")
      subject.classification.should eq "MY CLASSIFICATION"
    end
    it "should fall back to the model's class name" do
      the_model.stub(:classification).and_raise(NoMethodError)
      subject.classification.should eq "Mock"
    end
  end
end
