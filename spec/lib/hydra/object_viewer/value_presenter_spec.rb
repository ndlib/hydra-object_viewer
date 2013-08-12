require 'spec_helper'
require 'hydra/object_viewer/value_presenter'
module Hydra::ObjectViewer

  describe ValuePresenter do
    let(:the_attribute) { double }
    let(:the_context) { double }

    subject { Hydra::ObjectViewer::ValuePresenter.new(the_attribute, the_context) }

    it { should be_a_kind_of ValuePresenter }

    it "renders the appropriate partial" do
      template = double
      template.should_receive(:render).
        with(partial: 'attribute', locals: {presenter: subject}).
        and_return("THE_HTML")

      expect(subject.render(template)).to eq("THE_HTML")
    end

    it {should respond_to(:dom_class) }
    it {should respond_to(:name) }

    its(:value) { should == the_attribute }

  end

end
