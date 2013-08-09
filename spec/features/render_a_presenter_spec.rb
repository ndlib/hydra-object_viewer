require 'spec_helper'

describe 'Render A Presenter' do
  let(:object) { Watch.create(title: "My Title", description: "My Description") }
  let(:engine_mount_point) {
    # This may very well change and could be very fragile. In our use case
    # I am not as concerned.
    #
    # https://github.com/rails/rails/issues/4940
    Hydra::ObjectViewer::Engine.routes._generate_prefix({})
  }
  let(:path_to_object) {
    File.join(engine_mount_point, object.to_param)
  }
  it do
    visit path_to_object
    expect(page).to have_tag(".object-viewer#watch_#{object.id}") do
      with_tag('.primary-content') do
        with_tag('.title', text: object.title )
        with_tag('.classification', text: 'Watch' )
        with_tag('.description')
      end

      with_tag('.related')
    end
  end
end