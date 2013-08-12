require 'spec_helper'

describe 'hydra/object_viewer/application/_header_group' do
  let(:the_presenter) { double(title: "My Title", classification: "Fish") }

  before(:each) do
    view.stub(:presenter).and_return(the_presenter)
  end

  it 'renders the title' do
    render
    rendered.should have_tag('.title', text: the_presenter.title)
  end

  it 'renders the classification' do
    render
    rendered.should have_tag('.classification', text: the_presenter.classification)
  end

end
