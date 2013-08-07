require 'spec_helper'
require 'hydra/object_viewer/application_controller'

describe Hydra::ObjectViewer::ApplicationController do
  let(:object_id) { '1234' }
  it 'renders a persisted object' do
    get :show, id: object_id
    expect(response.status).to eq(200)
  end
end