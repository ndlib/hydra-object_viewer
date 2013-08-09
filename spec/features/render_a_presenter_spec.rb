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
  xit do
    visit path_to_object
  end
end