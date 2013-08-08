require 'spec_helper'

describe Hydra::ObjectViewer::Presenter do
  def model_factory
    double(title: 'The Model Name', description: 'The Model Description')
  end

  let(:the_model) { model_factory }
  let(:the_context) { double }
  subject { Hydra::ObjectViewer::Presenter.new(the_model, the_context) }

  it {should respond_to(:model) }
  it {should respond_to(:context) }
  it {should respond_to(:container_model_context) }
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

  describe 'related_contents' do
    before(:each) do
      subject.presenter_builder = lambda {|*args|
        Hydra::ObjectViewer::Presenter.new(*args)
      }
    end
    let(:subclass) {

      Class.new(Hydra::ObjectViewer::Presenter) {
        def initialize(related_content_collection, *args)
          @related_content_collection = related_content_collection
          super(*args)
        end
        attr_reader :related_content_collection
        related_contents :related_content_collection
      }

    }
    let(:related_content) { [model_factory, model_factory] }
    let(:subject) { subclass.new(related_content, the_model, the_context)}

    it 'is set via a class method which in turn converts that collection to a collection of presenters' do
      subject.related_contents.each_with_index do |content, i|
        expect(content.model).to eq(related_content[i])
      end
    end
  end
end
