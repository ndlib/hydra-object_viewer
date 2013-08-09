require 'spec_helper'

describe Hydra::ObjectViewer::Presenter do
  def model_factory
    double(title: 'The Model Name', description: 'The Model Description')
  end

  let(:the_model) { model_factory }
  let(:the_context) { double }
  subject { Hydra::ObjectViewer::Presenter.new(the_model, the_context) }

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

  describe '.presents' do
    before(:each) do
      the_model.stub(:related_contents).and_return(the_related_contents)
      subject.presenter_builder = lambda {|*args|
        Hydra::ObjectViewer::Presenter.new(*args)
      }
    end
    let(:subclass) {
      Class.new(Hydra::ObjectViewer::Presenter) {
        presents(:related_contents) {
          model.related_contents
        }
        presents(:bacon, :foo)
        def foo; ['foo method']; end
      }
    }
    let(:the_related_contents) { [model_factory, model_factory] }
    let(:subject) { subclass.new(the_model, the_context)}

    it 'wraps the configured via a proc in a presenter' do
      subject.related_contents.each_with_index do |content, i|
        expect(content.send(:model)).to eq(the_related_contents[i])
      end
    end

    it 'wraps the configured via a symbol in a presenter' do
      subject.bacon.each_with_index do |content, i|
        expect(content.send(:model)).to eq(subject.foo.first)
      end
    end

  end

  it "renders primary_content with the appropriate partial" do
    template = double
    template.should_receive(:render).
      with(partial: 'primary_content', locals: {presenter: subject}).
      and_return("THE_HTML")

    expect(subject.render_primary_content(template)).to eq("THE_HTML")
  end

  describe 'render_related_content' do
    it 'renders nothing if related_contents are not defined' do
      template = double
      expect(subject.render_related_content(template)).to be_empty
    end

    it 'renders the template if related_contents are present' do
      def subject.related_contents
        [1,2,3]
      end
      template = double
      template.should_receive(:render).
        with(partial: 'related_content', locals: {presenter: subject, related_contents: subject.related_contents}).
        and_return("THE_HTML")
      expect(subject.render_related_content(template)).to eq("THE_HTML")
    end
  end

end
