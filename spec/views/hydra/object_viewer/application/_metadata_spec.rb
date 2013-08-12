require 'spec_helper'

describe 'hydra/object_viewer/application/_metadata' do
  let(:the_presenter) { double(metadata_attributes: [presenter_for_creator, presenter_for_created_on]) }
  let(:presenter_for_creator) {
    double(render: %(<dt class="THE_CREATOR" />).html_safe )
  }
  let(:presenter_for_created_on) {
    double(render: %(<dt class="THE_CREATED_ON" />).html_safe )
  }

  before(:each) do
    view.stub(:presenter).and_return(the_presenter)
  end

  it 'renders the metadata, delegating to each attribute' do
    render
    rendered.should have_tag('.metadata') do
      with_tag(".THE_CREATOR")
      with_tag(".THE_CREATED_ON")
    end
  end

end
