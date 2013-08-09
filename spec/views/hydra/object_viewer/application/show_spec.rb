require 'spec_helper'

describe 'hydra/object_viewer/application/show' do
  let(:the_presenter) {
    double(
      description: %(<p id="lorem-id">Lorem Ipsum</p>).html_safe,
      title: %(Hello World),
      classification: "Collection",
      dom_id: rand(1000)
    )
  }

  before(:each) do
    view.stub(:presenter).and_return(the_presenter)
    the_presenter.should_receive(:render_related_content).with(view).and_return("<div id='RENDERED_RELATED_CONTENT'></div>".html_safe)
  end

  describe 'with related contents' do
    it 'renders the show page' do
      render
      rendered.should have_tag('.object-viewer') do
        with_tag('.primary-content') do
          with_tag('.title', text: the_presenter.title)
          with_tag('.classification', text: the_presenter.classification)
          with_tag('.description p#lorem-id')
        end

        with_tag('#RENDERED_RELATED_CONTENT')
      end
    end
  end

end
