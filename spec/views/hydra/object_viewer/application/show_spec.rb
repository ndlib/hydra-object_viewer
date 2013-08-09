require 'spec_helper'

describe 'hydra/object_viewer/application/show' do
  let(:the_presenter) {
    double(dom_id: rand(1000))
  }

  before(:each) do
    view.stub(:presenter).and_return(the_presenter)
    the_presenter.should_receive(:render_related_content).with(view).and_return("<div id='RENDERED_RELATED_CONTENT'></div>".html_safe)
    the_presenter.should_receive(:render_primary_content).with(view).and_return("<div id='RENDERED_PRIMARY_CONTENT'></div>".html_safe)
  end

  describe 'with related contents' do
    it 'renders the show page' do
      render
      rendered.should have_tag('.object-viewer') do
        with_tag('.primary-content') do
          with_tag('#RENDERED_PRIMARY_CONTENT')
        end

        with_tag('#RENDERED_RELATED_CONTENT')
      end
    end
  end

end
